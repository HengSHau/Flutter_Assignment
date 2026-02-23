import 'package:flutter/material.dart';

class ChatPageViewModel extends ChangeNotifier {
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final List<Map<String, dynamic>> messages = [];
  int unreadCount = 0;
  bool isPageVisible = false;

  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    messages.add({
      'text': text,
      'isMe': true,
    });

    textController.clear();
    notifyListeners();
    _scrollToBottom();
  }

  void receiveMessage(String text, {bool pageVisible = true}) {
    messages.add({
      'text': text,
      'isMe': false,
    });

    if (!pageVisible) {
      unreadCount++;
    }

    notifyListeners();
    _scrollToBottom();
  }

  void markAsRead() {
    if(unreadCount == 0) return;

    unreadCount = 0;
    notifyListeners();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}