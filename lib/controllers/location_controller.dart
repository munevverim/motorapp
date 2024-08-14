import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LocationController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Kullanıcının mevcut konumunu alır
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Konum servisleri etkin mi?
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Konum izni kontrolü ve isteme
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Kullanıcının mevcut konumunu döndür
    return await Geolocator.getCurrentPosition();
  }

  // Kullanıcının konumunu Firestore'a kaydeder
  Future<void> updateLocation(Position position) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _firestore.collection('locations').doc(user.uid).set({
        'latitude': position.latitude,
        'longitude': position.longitude,
        'timestamp': FieldValue.serverTimestamp(),
        'userId': user.uid,
      });
    }
  }

  // Kullanıcının konumunu alır ve Firestore'a kaydeder
  Future<void> getLocationAndSave() async {
    try {
      final position = await getCurrentLocation();
      if (position != null) {
        await updateLocation(position);
      }
    } catch (e) {
      print(e);
    }
  }
}
