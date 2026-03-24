import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_assignment/features/customer/models/course_model.dart';

class CustomerDiscoverViewModel extends ChangeNotifier {
  bool _isLoading = true;
  List<CourseModel> _allCourses = [];
  List<CourseModel> _filteredCourses = [];
  String _currentCategory = 'All'; 

  StreamSubscription? _coursesSubscription;

  bool get isLoading => _isLoading;
  List<CourseModel> get filteredCourses => _filteredCourses;

  CustomerDiscoverViewModel() {
    _startListeningToCourses();
  }

  void _startListeningToCourses() {
    _isLoading = true;
    notifyListeners();

    _coursesSubscription?.cancel();

    _coursesSubscription = FirebaseFirestore.instance
        .collection('courses')
        .where('isBooked', isEqualTo: false)
        .where('scheduledTime', isGreaterThanOrEqualTo: Timestamp.now())
        .snapshots() 
        .listen((snapshot) {    
      _allCourses = snapshot.docs.map((doc) {
        return CourseModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();

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
      if (studentId == course.tutorId) return 'You cannot book your own Class!';

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

      await FirebaseFirestore.instance.collection('bookings').add({
        'courseId': course.id,
        'courseTitle': course.title,
        'studentId': studentId,
        'tutorId': course.tutorId,
        'scheduledTime': Timestamp.fromDate(course.scheduledTime),
        'meetLink': course.meetLink,
        'timeStamp': FieldValue.serverTimestamp(),
      });

      await FirebaseFirestore.instance
          .collection('courses')
          .doc(course.id)
          .update({'isBooked': true});

      return 'Success';
    } catch (e) {
      print('Booking Error $e');
      return "An Error Occurred while Booking.";
    }
  }

  @override
  void dispose() {
    _coursesSubscription?.cancel();
    super.dispose();
  }
}