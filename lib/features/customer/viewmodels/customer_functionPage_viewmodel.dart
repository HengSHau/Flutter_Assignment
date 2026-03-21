import 'package:flutter/material.dart';

class CustomerFunctionViewModel extends ChangeNotifier {
  // These labels match the "Discover" and "My Course" sections in your proposal
  final List<String> tabs = ['Discover', 'My Courses'];
  
  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;

  void changeTab(int index) {
    _currentTabIndex = index;
    // This allows other parts of the UI to react if needed
    notifyListeners(); 
  }
}