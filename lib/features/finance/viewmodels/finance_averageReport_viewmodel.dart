import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/finance_ReportData_model.dart';

class FinanceAverageViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<FinanceReportData>> getCategoryPriceData() {
    return _firestore.collection('courses')
    .where('isBooked', isEqualTo: false)
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
          .map((entry) => FinanceReportData(
                label: entry.key,
                value: entry.value,
              ))
          .toList();
    });
  }

  double getAverage(List<FinanceReportData> data) {
    if (data.isEmpty) return 0;

    double total = 0;
    for (final item in data) {
      total += item.value;
    }
    return total / data.length;
  }

  double getMaxY(List<FinanceReportData> data) {
    if (data.isEmpty) return 10;

    double highest = 0;
    for (final item in data) {
      if (item.value > highest) {
        highest = item.value;
      }
    }

    final average = getAverage(data);
    if (average > highest) {
      highest = average;
    }

    return highest + 5;
  }
}