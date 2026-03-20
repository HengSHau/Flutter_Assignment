import 'package:flutter/material.dart';

class FinanceFunctionViewModel {
  final List<String> tabs = [
    'Daily',
    'Monthly',
    'Yearly'
  ];

  int currentIndex = 0;

  void changeTab(int index) {
    currentIndex = index;
  }
}