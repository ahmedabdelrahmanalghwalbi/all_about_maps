import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserTracking extends StatefulWidget {
  const UserTracking({super.key});

  @override
  State<UserTracking> createState() => _UserTrackingState();
}

class _UserTrackingState extends State<UserTracking> {
  GoogleMapController? _controller;

  CollectionReference? locationCollection =
      FirebaseFirestore.instance.collection('driver_location');

  LatLng? _driverLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User App'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.7749, -122.4194), // San Francisco coordinates
          zoom: 12,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
          _startTrackingDriverLocation();
        },
        markers: _driverLocation != null
            ? {
                Marker(
                  markerId: const MarkerId('driver_location'),
                  position: _driverLocation!,
                  icon: BitmapDescriptor.defaultMarker,
                )
              }
            : {},
      ),
    );
  }

  void _startTrackingDriverLocation() {
    locationCollection
        ?.doc('driver_1')
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        double latitude = data['latitude'];
        double longitude = data['longitude'];
        setState(() {
          _driverLocation = LatLng(latitude, longitude);
          _moveCameraToDriverLocation();
        });
      }
    });
  }

  void _moveCameraToDriverLocation() {
    if (_controller != null && _driverLocation != null) {
      _controller?.animateCamera(CameraUpdate.newLatLng(_driverLocation!));
    }
  }
}
