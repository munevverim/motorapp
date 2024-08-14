import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  BitmapDescriptor? _customIcon;

  @override
  void initState() {
    super.initState();
    _loadCustomIcon();
    _fetchAndListenToLocations();
  }

  Future<void> _loadCustomIcon() async {
    _customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      'assets/icons/location_icon.png', // Özel ikonun yolu
    );
  }

  void _fetchAndListenToLocations() {
    FirebaseFirestore.instance.collection('locations').snapshots().listen((snapshot) {
      _updateMarkers(snapshot.docs);
    });
  }

  void _updateMarkers(List<DocumentSnapshot> documentList) {
    final Set<Marker> newMarkers = {};
    for (var doc in documentList) {
      final data = doc.data() as Map<String, dynamic>;
      final marker = Marker(
        markerId: MarkerId(data['userId']),
        position: LatLng(data['latitude'], data['longitude']),
        icon: _customIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: 'User ${data['userId']}',
          snippet: 'Updated at ${data['timestamp'].toDate()}',
        ),
      );
      newMarkers.add(marker);
    }
    setState(() {
      _markers.clear();
      _markers.addAll(newMarkers);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real-time User Locations'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194), // Başlangıç pozisyonu
          zoom: 12.0,
        ),
        markers: _markers,
      ),
    );
  }
}
