import 'dart:async'; 
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_assignment/features/customer/models/course_model.dart';

class CustomerLearningViewModel extends ChangeNotifier {
  bool _isLoading = true;
  List<CourseModel> _bookedCourses = [];
  
  StreamSubscription? _bookingSubscription;

  bool get isLoading => _isLoading;
  List<CourseModel> get bookedCourses => _bookedCourses;

  CustomerLearningViewModel() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        _bookingSubscription?.cancel(); 
        _bookedCourses = [];
        _isLoading = false;
        notifyListeners();
      } else {
        _startListeningToBookings(user.uid);
      }
    });
  }

  void _startListeningToBookings(String uid) {
    _isLoading = true;
    notifyListeners();

    _bookingSubscription?.cancel();

    _bookingSubscription = FirebaseFirestore.instance
        .collection('bookings')
        .where('studentId', isEqualTo: uid)
        .snapshots() 
        .listen((bookingSnapshot) async {

      List<String> courseIds = bookingSnapshot.docs
          .map((doc) => doc['courseId'] as String)
          .toList();

      if (courseIds.isEmpty) {
        _bookedCourses = [];
      } else {
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
      notifyListeners(); 
    }, onError: (error) {
      print('Error in booking stream: $error');
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> cancelBooking(String courseId) async {
    try {
      String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
      if (uid.isEmpty) return;

      QuerySnapshot bookingSnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('studentId', isEqualTo: uid)
          .where('courseId', isEqualTo: courseId)
          .get();

      for (var doc in bookingSnapshot.docs) {
        await doc.reference.delete();
      }

      await FirebaseFirestore.instance
          .collection('courses')
          .doc(courseId)
          .update({'isBooked': false});

      
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