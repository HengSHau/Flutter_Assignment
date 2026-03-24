import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_assignment/features/customer/models/course_model.dart';

class CustomerTeachingViewmodel extends ChangeNotifier {
  bool _isLoading = true;
  List<CourseModel> _taughtCourses = [];
  
  StreamSubscription? _courseSubscription;

  bool get isLoading => _isLoading;
  List<CourseModel> get taughtCourses => _taughtCourses;

  CustomerTeachingViewmodel() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        _courseSubscription?.cancel(); 
        _taughtCourses = [];
        _isLoading = false;
        notifyListeners();
      } else {
        _startListeningToTaughtCourses(user.uid);
      }
    });
  }

  void _startListeningToTaughtCourses(String uid) {
    _isLoading = true;
    notifyListeners();

    _courseSubscription?.cancel();

    _courseSubscription = FirebaseFirestore.instance
        .collection('courses')
        .where('tutorId', isEqualTo: uid)
        .snapshots() 
        .listen((snapshot) {
      
      _taughtCourses = snapshot.docs.map((doc) {
        return CourseModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();

      _isLoading = false;
      notifyListeners(); 
    }, onError: (error) {
      print('Error listening to taught courses: $error');
      _isLoading = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _courseSubscription?.cancel();
    super.dispose();
  }
}