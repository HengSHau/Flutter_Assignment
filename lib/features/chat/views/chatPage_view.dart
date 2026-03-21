import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_assignment/features/chat/viewmodels/chatPage_viewmodel.dart';
import 'package:flutter_assignment/features/chat/model/message_model.dart';

class ChatPage extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;
  final String chatId; // CRITICAL: Tells the page which room we are in
  final String otherUserName; 
  final String otherUserId;

  const ChatPage({
    super.key, 
    required this.themeNotifier, 
    required this.chatId, 
    required this.otherUserName,
    required this.otherUserId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState(){
    super.initState();
    Future.microtask((){
      context.read<ChatPageViewModel>().markAsRead(widget.chatId);
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ChatPageViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.otherUserName),
      ),
      body: Column(
        children: [
          // 1. The Message List
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: viewModel.getMessagesStream(widget.chatId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
              

                final messages = snapshot.data!;

                return ListView.builder(
                  reverse: true, // Auto-scrolls to the bottom
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message.senderId == viewModel.currentUserId;

                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          message.text,
                          style: TextStyle(color: isMe ? Colors.white : Colors.black),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // 2. The Text Input Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      viewModel.sendMessage(widget.chatId, widget.otherUserId,_messageController.text);
                      _messageController.clear();
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}