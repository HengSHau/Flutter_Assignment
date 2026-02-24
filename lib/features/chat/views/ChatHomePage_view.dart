import 'package:flutter/material.dart';
import 'package:flutter_assignment/features/chat/views/chatPage_view.dart';

class ChatItem {
  final String name;
  final String lastMessage;
  final String time;
  int unread;

  ChatItem({
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unread = 0, 
  });

}

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({super.key, required this.themeNotifier});
  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  State<ChatHomePage> createState() => ChatHomePageState();
}

class ChatHomePageState extends State<ChatHomePage> {
  final List<ChatItem> chats = List.generate(
    10,
    (i) => ChatItem(
      name: 'User $i',
      lastMessage: 'Hello 👋',
      time: '12:30',
      unread: i % 3 == 0 ? 1 : 0,
    ),
  );

  @override
  Widget build(BuildContext context) {
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
            child: ListView.separated(
              itemCount: chats.length,
              separatorBuilder: (_, __) => const Divider(color: Colors.transparent,height: 0),
              itemBuilder: (context, index) {
                final chat = chats[index];

                return ListTile(
                  leading: Stack(
                    children: [
                      const CircleAvatar(
                        child: Icon(Icons.person),
                      ),

                      if (chat.unread > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.red,
                            child: Text(
                              chat.unread.toString(),
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  title: Text(chat.name),
                  subtitle: Text(
                    chat.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(
                    chat.time,
                    style: const TextStyle(fontSize: 12),
                  ),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatPage(themeNotifier: widget.themeNotifier),
                      ),
                    );

                    setState(() {
                      chat.unread = 0;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
