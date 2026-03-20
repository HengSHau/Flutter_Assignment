import 'package:flutter/material.dart';
import 'package:flutter_assignment/features/finance/models/finance_barData_model.dart';

class FinanceDailyViewModel extends ChangeNotifier {
  DateTimeRange? selectedRange;

  List<FinanceBarData> chartData = [];

  Future<void> pickDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedRange = picked;

      chartData = _generateData(picked);

      notifyListeners();
    }
  }

  List<FinanceBarData> _generateData(DateTimeRange range) {
    List<FinanceBarData> data = [];

    DateTime current = range.start;

    while (!current.isAfter(range.end)) {
      data.add(
        FinanceBarData(
          label: '${current.day}/${current.month}', // 👈 关键
          value: (20 + current.day * 5).toDouble(), // 假数据
        ),
      );

      current = current.add(const Duration(days: 1));
    }

    return data;
  }

  String get rangeText {
    if (selectedRange == null) {
      return 'No date range selected';
    }

    final from = selectedRange!.start;
    final to = selectedRange!.end;

    return '${from.day}/${from.month}/${from.year}  -  ${to.day}/${to.month}/${to.year}';
  }
}