import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MotorcyclistListScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Motorcyclists'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').where('role', isEqualTo: 'motorcyclist').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final motorcyclists = snapshot.data!.docs;
          return ListView.builder(
            itemCount: motorcyclists.length,
            itemBuilder: (context, index) {
              final motorcyclist = motorcyclists[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(motorcyclist['profilePictureUrl']),
                  ),
                  title: Text(motorcyclist['name']),
                  subtitle: Text(motorcyclist['bio'] ?? 'No bio available'),
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
