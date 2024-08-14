import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PassengerListScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passengers'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').where('role', isEqualTo: 'passenger').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final passengers = snapshot.data!.docs;
          return ListView.builder(
            itemCount: passengers.length,
            itemBuilder: (context, index) {
              final passenger = passengers[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(passenger['profilePictureUrl']),
                  ),
                  title: Text(passenger['name']),
                  subtitle: Text(passenger['bio'] ?? 'No bio available'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    // Detay sayfasına yönlendirme kodu
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
