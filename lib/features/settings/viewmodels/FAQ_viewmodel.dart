import 'package:flutter/material.dart';

class HelpItem {
  final String question;
  final String answer;

  HelpItem({
    required this.question,
    required this.answer,
  });
}

class HelpSupportViewModel extends ChangeNotifier {
  int? selectedIndex;

  final List<HelpItem> helpItems = [
    HelpItem(
      question: 'How to reset password?',
      answer: 'Go to settings and click reset password.',
    ),
    HelpItem(
      question: 'How to contact support?',
      answer: 'You can contact support via email or live chat.',
    ),
    HelpItem(
      question: 'How to check order status?',
      answer: 'Open your order page to view current order status.',
    ),
  ];

  void toggleItem(int index) {
    if (selectedIndex == index) {
      selectedIndex = null;
    } else {
      selectedIndex = index;
    }
    notifyListeners();
  }

  bool isExpanded(int index) {
    return selectedIndex == index;
  }
}