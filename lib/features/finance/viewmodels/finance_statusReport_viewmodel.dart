import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/finance_sessionData_model.dart';

class FinanceStatusReportViewData extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String collectionName = 'courses';

  Stream<List<FinanceSessionData>> getBookedSessions() {
    return _firestore
        .collection(collectionName)
        .where('isBooked', isEqualTo: true)
        .orderBy('scheduledTime')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => FinanceSessionData.fromFirestore(doc.id, doc.data()))
          .toList();
    });
  }

  double getCompletedTotal(List<FinanceSessionData> sessions) {
    final now = DateTime.now();
    double total = 0;

    for (final item in sessions) {
      if (item.scheduledTime.isBefore(now)) {
        total += item.price;
      }
    }

    return total;
  }

  double getUpcomingTotal(List<FinanceSessionData> sessions) {
    final now = DateTime.now();
    double total = 0;

    for (final item in sessions) {
      if (!item.scheduledTime.isBefore(now)) {
        total += item.price;
      }
    }

    return total;
  }

  List<FinanceSessionData> getUpcomingSessions(
    List<FinanceSessionData> sessions,
  ) {
    final now = DateTime.now();

    return sessions
        .where((item) => !item.scheduledTime.isBefore(now))
        .toList();
  }

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} '
        '${_twoDigits(dateTime.hour)}:${_twoDigits(dateTime.minute)}';
  }

  String _twoDigits(int value) => value.toString().padLeft(2, '0');
}