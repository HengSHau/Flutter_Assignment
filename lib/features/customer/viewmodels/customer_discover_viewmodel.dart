import 'dart:async'; // Required for StreamSubscription
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_assignment/features/customer/models/course_model.dart';

class CustomerDiscoverViewModel extends ChangeNotifier {
  bool _isLoading = true;
  List<CourseModel> _allCourses = [];
  List<CourseModel> _filteredCourses = [];
  String _currentCategory = 'All'; // Track current filter
  
  // To prevent memory leaks, we store the subscription
  StreamSubscription? _coursesSubscription;

  bool get isLoading => _isLoading;
  List<CourseModel> get filteredCourses => _filteredCourses;

  CustomerDiscoverViewModel() {
    _startListeningToCourses();
  }

  // ✨ THE LIVE FEED: Listen to Firestore snapshots
  void _startListeningToCourses() {
    _isLoading = true;
    notifyListeners();

    // Cancel existing subscription if it exists
    _coursesSubscription?.cancel();

    _coursesSubscription = FirebaseFirestore.instance
        .collection('courses')
        .where('isBooked', isEqualTo: false) // Only show available slots
        .snapshots() // This is the magic "Live" part
        .listen((snapshot) {
      
      _allCourses = snapshot.docs.map((doc) {
        return CourseModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();

      // Automatically apply the current filter whenever the database changes
      _applyFilter();
      
      _isLoading = false;
      notifyListeners();
    }, onError: (error) {
      print('Stream Error: $error');
      _isLoading = false;
      notifyListeners();
    });
  }

  void filterByCategory(String category) {
    _currentCategory = category;
    _applyFilter();
    notifyListeners();
  }

  // Helper method to keep filtering consistent
  void _applyFilter() {
    if (_currentCategory == 'All') {
      _filteredCourses = List.from(_allCourses);
    } else {
      _filteredCourses = _allCourses
          .where((course) => course.category == _currentCategory)
          .toList();
    }
  }

  Future<String> bookCourse(CourseModel course) async {
    try {
      String studentId = FirebaseAuth.instance.currentUser?.uid ?? '';
      if (studentId.isEmpty) return "Error: Not Logged in.";

      if (studentId == course.tutorId) {
        return 'You cannot book your own Class!';
      }

      // 1. Clash Detection
      QuerySnapshot userBookings = await FirebaseFirestore.instance
          .collection('bookings')
          .where('studentId', isEqualTo: studentId)
          .get();

      for (var doc in userBookings.docs) {
        if (doc['scheduledTime'] != null) {
          DateTime existingClassTime = (doc['scheduledTime'] as Timestamp).toDate();
          if (existingClassTime.isAtSameMomentAs(course.scheduledTime)) {
            return "Schedule Clash! You already have a class at this time.";
          }
        }
      }

      // 2. Double Check Availability
      DocumentSnapshot courseCheck = await FirebaseFirestore.instance
          .collection('courses')
          .doc(course.id)
          .get();
      
      if (courseCheck.exists && (courseCheck.data() as Map<String, dynamic>)['isBooked'] == true) {
        return "Sorry, this slot was just taken!";
      }

      // 3. Create Booking
      await FirebaseFirestore.instance.collection('bookings').add({
        'courseId': course.id,
        'courseTitle': course.title,
        'studentId': studentId,
        'tutorId': course.tutorId,
        'scheduledTime': Timestamp.fromDate(course.scheduledTime),
        'meetLink': course.meetLink,
        'timeStamp': FieldValue.serverTimestamp(),
      });

      // 4. Update Course Status
      await FirebaseFirestore.instance
          .collection('courses')
          .doc(course.id)
          .update({'isBooked': true});

      // NOTE: We no longer need to call fetchAllCourses() here! 
      // The Stream listener above will detect the change in 'isBooked' 
      // and remove the course from the UI automatically.

      return 'Success';
    } catch (e) {
      print('Booking Error $e');
      return "An Error Occurred while Booking.";
    }
  }

  @override
  void dispose() {
    _coursesSubscription?.cancel(); // Clean up the listener when done
    super.dispose();
  }
}