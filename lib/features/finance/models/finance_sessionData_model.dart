import 'package:cloud_firestore/cloud_firestore.dart';

class FinanceSessionData {
  final String id;
  final String category;
  final String title;
  final String tutorName;
  final double price;
  final DateTime scheduledTime;
  final bool isBooked;

  FinanceSessionData({
    required this.id,
    required this.category,
    required this.title,
    required this.tutorName,
    required this.price,
    required this.scheduledTime,
    required this.isBooked,
  });

  factory FinanceSessionData.fromFirestore(
    String id,
    Map<String, dynamic> data,
  ) {
    return FinanceSessionData(
      id: id,
      category: data['category'] ?? '',
      title: data['title'] ?? '',
      tutorName: data['tutorName'] ?? '',
      price: (data['price'] as num).toDouble(),
      scheduledTime: (data['scheduledTime'] as Timestamp).toDate(),
      isBooked: data['isBooked'] ?? false,
    );
  }
}