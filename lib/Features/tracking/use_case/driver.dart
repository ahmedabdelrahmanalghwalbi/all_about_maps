import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverTracking extends StatefulWidget {
  const DriverTracking({super.key});

  @override
  State<DriverTracking> createState() => _DriverTrackingState();
}

class _DriverTrackingState extends State<DriverTracking> {
  Position? _currentPosition;
  StreamSubscription<Position>? _positionStreamSubscription;
  CollectionReference locationCollection =
      FirebaseFirestore.instance.collection('driver_location');

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  void _getCurrentLocation() {
    _positionStreamSubscription = Geolocator.getPositionStream(
            //here i will make location setting as [Geolocator and location] Section
            )
        .listen((Position position) async {
      setState(() {
        _currentPosition = position;
      });
      await _updateLocationInFirestore(position);
    });
  }

  Future<void> _updateLocationInFirestore(Position position) async {
    try {
      await locationCollection.doc('driver_1').set({
        'latitude': position.latitude,
        'longitude': position.longitude,
        'timestamp': FieldValue.serverTimestamp(),
      });
      debugPrint('Location updated in Firestore');
    } catch (e) {
      debugPrint('Error updating location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _currentPosition != null
                ? Text(
                    'Current Location: ${_currentPosition?.latitude}, ${_currentPosition?.longitude}')
                : const CircularProgressIndicator.adaptive(),
          ],
        ),
      ),
    );
  }
}
