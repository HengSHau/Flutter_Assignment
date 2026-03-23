import 'package:cloud_firestore/cloud_firestore.dart'; // CRITICAL: Need this for Timestamp!

class CourseModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String tutorName;
  final String tutorId;
  final String meetLink;
  final DateTime scheduledTime;
  final bool isBooked; 
  final double price;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.tutorName,
    required this.tutorId,
    required this.meetLink,
    required this.scheduledTime,
    this.isBooked = false, 
    this.price = 0.0,
  });

  factory CourseModel.fromMap(String documentId, Map<String, dynamic> map) {
    return CourseModel(
      id: documentId,
      title: map['title'] ?? 'Untitled Course',
      description: map['description'] ?? 'No description Provided',
      category: map['category'] ?? 'General',
      tutorName: map['tutorName'] ?? 'Unknown Tutor',
      tutorId: map['tutorId'] ?? '', 
      meetLink: map['meetLink'] ?? 'https://meet.google.com/new',    
      // Convert Firestore Timestamp to Flutter DateTime
      scheduledTime: (map['scheduledTime'] as Timestamp).toDate(),
      isBooked: map['isBooked'] ?? false,
      price: (map['price'] ?? 0.0).toDouble(),
    );   
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'tutorName': tutorName,
      'tutorId': tutorId,
      'meetLink': meetLink, 
      // Convert Flutter DateTime to Firestore Timestamp
      'scheduledTime': Timestamp.fromDate(scheduledTime),
      'isBooked': isBooked,
      'price': price,
    };
  }
}