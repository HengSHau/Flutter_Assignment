import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_assignment/features/settings/models/feedback_model.dart';

class FeedbackViewmodel extends ChangeNotifier{
  bool _isLoading=false;
  bool get isLoading=>_isLoading;

  Future<String> submitFeedback(int rating,String comment) async{
    if(rating==0){
      return 'Please Select a star rating.';
    }
    if(comment.trim().isEmpty){
      return 'Please Provide your opinion on what can we improve';
    }

    _isLoading=true;
    notifyListeners();

    try{
      String uid=FirebaseAuth.instance.currentUser?.uid??'Unknown User';
      final newFeedback=FeedbackModel(
        userId: uid,
        rating: rating, 
        comment: comment.trim(), 
      );

      await FirebaseFirestore.instance.collection('feedback').add(newFeedback.toMap());

      _isLoading=false;
      notifyListeners();
      return 'Success';
    }catch(e){
      _isLoading=false;
      notifyListeners();
      return 'An Error Occurred: $e';
    }
  }
}