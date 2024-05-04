import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String receiverId;
  final String currentEmail;
  final String message;
  final Timestamp timestamp;

  Message(
      {required this.senderId,
      required this.receiverId,
      required this.currentEmail,
      required this.message,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'currentEmail': currentEmail,
      'message': message,
      'timestamp': timestamp
    };
  }
}
