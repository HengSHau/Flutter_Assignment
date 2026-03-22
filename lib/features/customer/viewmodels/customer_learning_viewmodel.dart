import 'dart:async'; // Required for StreamSubscription
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_assignment/features/customer/models/course_model.dart';

class CustomerLearningViewModel extends ChangeNotifier {
  bool _isLoading = true;
  List<CourseModel> _bookedCourses = [];
  
  // ✨ THE LIVE SUBSCRIPTION
  StreamSubscription? _bookingSubscription;

  bool get isLoading => _isLoading;
  List<CourseModel> get bookedCourses => _bookedCourses;

  CustomerLearningViewModel() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        _bookingSubscription?.cancel(); // Stop listening on logout
        _bookedCourses = [];
        _isLoading = false;
        notifyListeners();
      } else {
        _startListeningToBookings(user.uid);
      }
    });
  }

  // ✨ THE LIVE FEED: Listening to the "bookings" collection
  void _startListeningToBookings(String uid) {
    _isLoading = true;
    notifyListeners();

    _bookingSubscription?.cancel();

    _bookingSubscription = FirebaseFirestore.instance
        .collection('bookings')
        .where('studentId', isEqualTo: uid)
        .snapshots() // 1. Listen for new or removed bookings
        .listen((bookingSnapshot) async {
      
      // Extract course IDs from the current bookings
      List<String> courseIds = bookingSnapshot.docs
          .map((doc) => doc['courseId'] as String)
          .toList();

      if (courseIds.isEmpty) {
        _bookedCourses = [];
      } else {
        // 2. Fetch the full course details for each ID
        List<CourseModel> courses = [];
        for (String courseId in courseIds) {
          DocumentSnapshot courseDoc = await FirebaseFirestore.instance
              .collection('courses')
              .doc(courseId)
              .get();

          if (courseDoc.exists) {
            courses.add(CourseModel.fromMap(
              courseDoc.id, 
              courseDoc.data() as Map<String, dynamic>
            ));
          }
        }
        _bookedCourses = courses;
      }

      _isLoading = false;
      notifyListeners(); // 3. Refresh UI instantly!
    }, onError: (error) {
      print('Error in booking stream: $error');
      _isLoading = false;
      notifyListeners();
    });
  }

  // ✨ OPTIONAL: Added the Cancel Booking logic we discussed!
  Future<void> cancelBooking(String courseId) async {
    try {
      String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
      if (uid.isEmpty) return;

      // Find the booking record
      QuerySnapshot bookingSnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('studentId', isEqualTo: uid)
          .where('courseId', isEqualTo: courseId)
          .get();

      // Delete the booking
      for (var doc in bookingSnapshot.docs) {
        await doc.reference.delete();
      }

      // Update the course to be available again for others
      await FirebaseFirestore.instance
          .collection('courses')
          .doc(courseId)
          .update({'isBooked': false});

      // NOTE: We don't need to call any refresh method here.
      // The Stream listener above will detect the deletion in the 'bookings' 
      // collection and update the UI automatically!
      
    } catch (e) {
      print("Error canceling booking: $e");
    }
  }

  @override
  void dispose() {
    _bookingSubscription?.cancel();
    super.dispose();
  }
}