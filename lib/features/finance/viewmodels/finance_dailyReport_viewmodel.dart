import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/finance_reportData_model.dart';

class FinanceDailyViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late DateTime fromDate;
  late DateTime toDate;

  FinanceDailyViewModel() {
    final now = DateTime.now();
    fromDate = DateTime(now.year, now.month, now.day);
    toDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
  }

  Future<void> pickFromDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: fromDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      fromDate = DateTime(picked.year, picked.month, picked.day);

      if (fromDate.isAfter(toDate)) {
        toDate = DateTime(
          picked.year,
          picked.month,
          picked.day,
          23,
          59,
          59,
        );
      }

      notifyListeners();
    }
  }

  Future<void> pickToDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: toDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      toDate = DateTime(picked.year, picked.month, picked.day, 23, 59, 59);

      if (toDate.isBefore(fromDate)) {
        fromDate = DateTime(picked.year, picked.month, picked.day);
      }

      notifyListeners();
    }
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Stream<List<FinanceReportData>> getDailyCategoryData() {
    return _firestore
        .collection('courses')
        .where(
          'scheduledTime',
          isGreaterThanOrEqualTo: Timestamp.fromDate(fromDate),
        )
        .where(
          'scheduledTime',
          isLessThanOrEqualTo: Timestamp.fromDate(toDate),
        )
        .where('isBooked', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      final Map<String, double> groupedData = {};

      for (final doc in snapshot.docs) {
        final data = doc.data();

        final String category = data['category'] ?? 'Unknown';
        final double price = (data['price'] as num).toDouble();

        groupedData[category] = (groupedData[category] ?? 0) + price;
      }

      return groupedData.entries
          .map(
            (entry) => FinanceReportData(
              label: entry.key,
              value: entry.value,
            ),
          )
          .toList();
    });
  }

  double getMaxY(List<FinanceReportData> data) {
    if (data.isEmpty) return 10;

    double highest = 0;
    for (final item in data) {
      if (item.value > highest) {
        highest = item.value;
      }
    }

    return highest + 5;
  }
}