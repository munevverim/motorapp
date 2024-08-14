import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final String userId;
  final String senderName; // senderName alanı eklendi
  final Timestamp timestamp;

  Message({
    required this.text,
    required this.userId,
    required this.senderName, // senderName zorunlu hale getirildi
    required this.timestamp,
  });

  factory Message.fromDocument(DocumentSnapshot doc) {
    return Message(
      text: doc['text'] ?? '', // Null kontrolü
      userId: doc['userId'] ?? '', // Null kontrolü
      senderName: doc['senderName'] ?? 'Anonymous', // Null kontrolü ve varsayılan değer
      timestamp: doc['timestamp'] ?? Timestamp.now(), // Null kontrolü
    );
  }
}
