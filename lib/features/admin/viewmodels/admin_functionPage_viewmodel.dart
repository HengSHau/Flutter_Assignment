import 'package:flutter/material.dart';

class AdminFunctionViewModel extends ChangeNotifier{
  final List<String> tabs = [
    'Add Staff',
    'Edit Staff',
    'View Report',
    'View Feedback'
  ];

  int currentIndex = 0;

  void changeTab(int index) {
    currentIndex = index;
  }

  String ? selectedRole;
  void changeRole(String?value){
    selectedRole = value;
    notifyListeners();
  }
}