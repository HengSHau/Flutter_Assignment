import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // ADDED
import '../model/message_model.dart';

class ChatPageViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // DYNAMIC DETECTION
  String get currentUserId => _auth.currentUser?.uid ?? '';

  Stream<List<MessageModel>> getMessagesStream(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => MessageModel.fromFirestore(doc)).toList();
    });
  }

  Future<void> markAsRead(String chatId) async{
    await _firestore.collection('chats').doc(chatId).update({
      'unreadCount.$currentUserId':0,
    });
  }

  Future<void> sendMessage(String chatId,String otherUserId, String text) async {
    if (text.trim().isEmpty) return;

    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'senderId': currentUserId, // Now uses your real Auth UID
      'text': text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    });

    await _firestore.collection('chats').doc(chatId).update({
      'lastMessage': text.trim(),
      'lastMessageTime': FieldValue.serverTimestamp(),
      'unreadCount.$otherUserId':FieldValue.increment(1),
    });
  }
}