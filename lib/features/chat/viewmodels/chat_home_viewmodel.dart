import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // ADDED
import '../model/chat_item_model.dart';

class ChatHomeViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get currentUserId => _auth.currentUser?.uid ?? '';

  Stream<List<ChatItemModel>> getChatStream() {
    if (currentUserId.isEmpty) return Stream.value([]);
    
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: currentUserId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ChatItemModel.fromFirestore(doc, currentUserId);
      }).toList();
    });
  }

  Stream<QuerySnapshot> getAllUsersStream() {
    return _firestore.collection('users').where('username',isNotEqualTo: 'Super Admin').snapshots();
  }

  Future<String> createOrGetChat(String otherUserId, String otherUserName) async {
    final query = await _firestore
        .collection('chats')
        .where('participants', arrayContains: currentUserId)
        .get();

    for (var doc in query.docs) {
      List<dynamic> participants = doc['participants'] ?? [];
      if (participants.contains(otherUserId)) {
        return doc.id;
      }
    }

    final newChatRef = _firestore.collection('chats').doc();
    
    String myName = _auth.currentUser?.displayName ?? 'Me';

    await newChatRef.set({
      'participants': [currentUserId, otherUserId],
      'participantNames': {
        currentUserId: myName,
        otherUserId: otherUserName,
      },
      'lastMessage': 'Chat started',
      'lastMessageTime': FieldValue.serverTimestamp(),
      'unreadCount': {
        currentUserId: 0,
        otherUserId: 0,
      }
    });

    return newChatRef.id;
  }
}