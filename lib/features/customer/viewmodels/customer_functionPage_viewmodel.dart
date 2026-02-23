import 'package:flutter/material.dart';

class CustomerFunctionViewModel {
  final List<String> tabs = [
    'Discover',
    'My Course',
  ];

  int currentIndex = 0;

  void changeTab(int index) {
    currentIndex = index;
  }
}