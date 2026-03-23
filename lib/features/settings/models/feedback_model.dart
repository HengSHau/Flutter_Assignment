import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  final String userId;
  final int rating;
  final String comment;
  final dynamic createdAt;

  FeedbackModel({
    required this.userId,
    required this.rating,
    required this.comment,
    this.createdAt,
  });

  Map<String,dynamic> toMap(){
    return{
      'userId':userId,
      'rating':rating,
      'comment':comment,
      'createdAt':createdAt??FieldValue.serverTimestamp(),
    };
  }
}