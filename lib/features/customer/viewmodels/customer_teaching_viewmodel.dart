import 'dart:async'; // Required for StreamSubscription
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_assignment/features/customer/models/course_model.dart';

class CustomerTeachingViewmodel extends ChangeNotifier {
  bool _isLoading = true;
  List<CourseModel> _taughtCourses = [];
  
  // ✨ THE LIVE SUBSCRIPTION: This stays open to listen for changes
  StreamSubscription? _courseSubscription;

  bool get isLoading => _isLoading;
  List<CourseModel> get taughtCourses => _taughtCourses;

  CustomerTeachingViewmodel() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        _courseSubscription?.cancel(); // Stop listening if logged out
        _taughtCourses = [];
        _isLoading = false;
        notifyListeners();
      } else {
        _startListeningToTaughtCourses(user.uid);
      }
    });
  }

  // ✨ THE LIVE FEED: No more manual "fetching"
  void _startListeningToTaughtCourses(String uid) {
    _isLoading = true;
    notifyListeners();

    // Cancel any old subscription before starting a new one
    _courseSubscription?.cancel();

    _courseSubscription = FirebaseFirestore.instance
        .collection('courses')
        .where('tutorId', isEqualTo: uid)
        .snapshots() // Listen for any changes in the database
        .listen((snapshot) {
      
      _taughtCourses = snapshot.docs.map((doc) {
        return CourseModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();

      _isLoading = false;
      notifyListeners(); // This triggers the UI refresh immediately
    }, onError: (error) {
      print('Error listening to taught courses: $error');
      _isLoading = false;
      notifyListeners();
    });
  }

  // ✨ CLEANUP: Important for memory management
  @override
  void dispose() {
    _courseSubscription?.cancel();
    super.dispose();
  }
}