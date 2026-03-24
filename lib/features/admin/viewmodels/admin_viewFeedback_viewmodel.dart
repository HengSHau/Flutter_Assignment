import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/admin_viewFeedback_model.dart';

class AdminFeedbackViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<FeedbackModel>> getAllFeedback() {
    return _firestore
        .collection('feedback')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => FeedbackModel.fromFirestore(doc))
          .toList();
    });
  }
}