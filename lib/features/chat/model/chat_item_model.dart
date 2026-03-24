import 'package:cloud_firestore/cloud_firestore.dart';

class ChatItemModel {
  final String chatId;
  final String otherUserName;
  final String otherUserId;
  final String lastMessage;
  final DateTime time;
  final int unread;

  ChatItemModel({
    required this.chatId,
    required this.otherUserName,
    required this.otherUserId,
    required this.lastMessage,
    required this.time,
    this.unread = 0,
  });

  factory ChatItemModel.fromFirestore(DocumentSnapshot doc, String currentUserId) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    DateTime parsedTime = DateTime.now();
    if (data['lastMessageTime'] != null) {
      parsedTime = (data['lastMessageTime'] as Timestamp).toDate();
    }

    Map<String, dynamic> names = data['participantNames'] ?? {};
    String otherName = 'Unknown User';
    String otherId='';
    names.forEach((uid, name) {
      if (uid != currentUserId) {
        otherName = name;
        otherId=uid;
      }
    });

    return ChatItemModel(
      chatId: doc.id,
      otherUserName: otherName,
      otherUserId: otherId,
      lastMessage: data['lastMessage'] ?? 'No messages yet',
      time: parsedTime,
      unread: data['unreadCount']?[currentUserId] ?? 0, 
    );
  }
}