class TutorCourseModel {
  final String courseId;
  final String tutorUid; 
  final String tutorName;
  final String category; 
  final double price;

  TutorCourseModel({
    required this.courseId,
    required this.tutorUid,
    required this.tutorName,
    required this.category,
    required this.price,
  });

  factory TutorCourseModel.fromMap(Map<String, dynamic> data, String documentId) {
    return TutorCourseModel(
      courseId: documentId,
      tutorUid: data['tutorUid'] ?? '',
      tutorName: data['tutorName'] ?? 'Unknown Tutor',
      category: data['category'] ?? 'General',
      price: (data['price'] ?? 0.0).toDouble(),
    );
  }
}