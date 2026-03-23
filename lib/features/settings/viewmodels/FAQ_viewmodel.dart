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
      answer: 'Go to profile and click reset password.',
    ),
    HelpItem(
      question: 'How to contact support?',
      answer: 'You can contact support via email or live chat or you may submit feedback.',
    ),
    HelpItem(
      question: 'How to check booked courses?',
      answer: 'Open your function page to view current booked courses.',
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