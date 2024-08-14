import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/message.dart';

class ChatController {
  Future<void> sendMessage(String text) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('messages').add({
        'text': text,
        'userId': user.uid,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  Stream<List<Message>> getMessages() {
    return FirebaseFirestore.instance
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Message.fromDocument(doc)).toList());
  }
}
