import 'package:flutter/material.dart';

class AdminFunctionViewModel {
  final List<String> tabs = [
    'Add Staff',
    'Edit Staff',
    'View Report'
  ];

  int currentIndex = 0;

  void changeTab(int index) {
    currentIndex = index;
  }
}