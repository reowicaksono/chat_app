import 'dart:developer';

import 'package:chat_app/src/shared/data/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUserList() {
    return _firestore.collection("users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String receiveId, message) async {
    final String currentId = _firebaseAuth.currentUser!.uid;
    final String currentEmail = _firebaseAuth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message messageModel = Message(
        senderId: currentId,
        receiverId: receiveId,
        message: message,
        currentEmail: currentEmail,
        timestamp: timestamp);
    List<String> ids = [currentId, receiveId];
    ids.sort();

    String chatId = ids.join("_");

    await _firestore
        .collection("chat_rooms")
        .doc(chatId)
        .collection("messages")
        .add(messageModel.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, othersID) {
    List<String> ids = [userId, othersID];
    ids.sort();
    String chatId = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
