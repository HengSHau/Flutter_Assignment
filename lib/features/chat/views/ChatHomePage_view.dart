import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:flutter_assignment/features/chat/viewmodels/chat_home_viewmodel.dart';
import 'package:flutter_assignment/features/chat/model/chat_item_model.dart';
import 'package:flutter_assignment/features/chat/views/chatPage_view.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({super.key, required this.themeNotifier});
  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  State<ChatHomePage> createState() => ChatHomePageState();
}

class ChatHomePageState extends State<ChatHomePage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ChatHomeViewModel>();

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search chats',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          Expanded(
            child: StreamBuilder<List<ChatItemModel>>(
              stream: viewModel.getChatStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No active conversations.'));
                }

                final chats = snapshot.data!;

                return ListView.separated(
                  itemCount: chats.length,
                  separatorBuilder: (_, __) => const Divider(color: Colors.transparent, height: 0),
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    
                    bool isUnread = chat.unread > 0;

                    String formattedTime = 
                        "${chat.time.hour.toString().padLeft(2, '0')}:${chat.time.minute.toString().padLeft(2, '0')}";

                    return ListTile(
                      leading: Stack(
                        children: [
                          const CircleAvatar(child: Icon(Icons.person)),
                          if (isUnread)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.red,
                                child: Text(
                                  chat.unread.toString(),
                                  style: const TextStyle(fontSize: 10, color: Colors.white),
                                ),
                              ),
                            ),
                        ],
                      ),
  
                      title: Text(
                        chat.otherUserName,
                        style:TextStyle(
                          fontWeight: isUnread? FontWeight.bold:FontWeight.normal,
                        ),
                      ), 

                      subtitle: Text(
                        chat.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                          color: isUnread ? Colors.black : Colors.grey[600],
                        ),
                      ),

                      trailing: Text(
                        formattedTime,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                          color: isUnread ? Colors.blue : Colors.grey,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatPage(
                              themeNotifier: widget.themeNotifier,
                              chatId: chat.chatId,
                              otherUserName: chat.otherUserName,
                              otherUserId: chat.otherUserId,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNewChatModal(context, viewModel),
        child: const Icon(Icons.chat),
      ),
    );
  }

  void _showNewChatModal(BuildContext context, ChatHomeViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Start a New Chat',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: viewModel.getAllUsersStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    
                    final allDocs = snapshot.data?.docs ?? [];
                    final users = allDocs.where((doc) => doc.id != viewModel.currentUserId).toList();

                    if (users.isEmpty) {
                      return const Center(child: Text('No other users found.'));
                    }

                    return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        var userData = users[index].data() as Map<String, dynamic>;
                        String name = userData['username'] ?? 'Unknown User';
                        String role = userData['role'] ?? 'User';
                        String otherUserId = users[index].id; 

                        return ListTile(
                          leading: const CircleAvatar(child: Icon(Icons.person)),
                          title: Text(name),
                          subtitle: Text(role),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () async {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const Center(child: CircularProgressIndicator()),
                            );

                            String newChatId = await viewModel.createOrGetChat(otherUserId, name);

                            if (context.mounted) {
                              Navigator.pop(context); 
                              Navigator.pop(context); 
                              
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ChatPage(
                                    themeNotifier: widget.themeNotifier,
                                    chatId: newChatId,
                                    otherUserName: name,
                                    otherUserId: otherUserId,
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}