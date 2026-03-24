import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  final String id;
  final String userId;
  final String message;
  final int rating;
  final Timestamp? createdAt;

  FeedbackModel({
    required this.id,
    required this.userId,
    required this.message,
    required this.rating,
    required this.createdAt,
  });

  factory FeedbackModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return FeedbackModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      message: data['comment'] ?? '',
      rating: data['rating'] ?? 0,
      createdAt: data['createdAt'],
    );
  }
}