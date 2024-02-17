import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class WatchMyLocationInStreamByUsingLocation extends StatefulWidget {
  const WatchMyLocationInStreamByUsingLocation({super.key});

  @override
  State<WatchMyLocationInStreamByUsingLocation> createState() =>
      _WatchMyLocationInStreamByUsingLocationState();
}

class _WatchMyLocationInStreamByUsingLocationState
    extends State<WatchMyLocationInStreamByUsingLocation> {
  StreamSubscription<LocationData>? _locationSubscription;
  LocationData? currentLocation;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    PermissionStatus permission = await Location.instance.hasPermission();
    if (permission == PermissionStatus.denied) {
      await _requestLocationPermission();
    } else {
      //Enables or disables service in the background mode.
      Location.instance.enableBackgroundMode(enable: true);
      _startListeningForLocationUpdates();
    }
  }

  Future<void> _requestLocationPermission() async {
    PermissionStatus permission = await Location.instance.requestPermission();
    if (permission == PermissionStatus.denied) {
      await _handlePermissionDenied();
    } else {
      _startListeningForLocationUpdates();
    }
  }

  Future<void> _handlePermissionDenied() async {
    bool goToSettings = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permissions Required'),
        content:
            const Text('Please enable location permissions to use this app.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, true); // Go to settings
            },
            child: const Text('Go to Settings'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, false); // Cancel
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );

    if (goToSettings) {
      await launchAppSettings();
    }
  }

  Future<void> launchAppSettings() async {
    await Location.instance.requestService();
  }

  void _startListeningForLocationUpdates() {
    try {
      _locationSubscription =
          Location.instance.onLocationChanged.listen((locationData) {
        // Handle location updates
        setState(() {
          currentLocation = locationData;
        });
      }, onError: (error) async {
        _errorMessage = error.toString();
        //Returns the last known position stored on the users device.
        currentLocation = null;
        setState(() {});
      });
    } catch (ex) {
      _errorMessage = ex.toString();
      //Returns null
      currentLocation = null;
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    _locationSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Watch My Current Location Stream Using Location :-",
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        if (_errorMessage != null)
          Text(
            'Error: $_errorMessage',
            style: const TextStyle(color: Colors.red),
          ),
        if (currentLocation != null)
          Column(
            children: [
              Text(
                'Latitude: ${currentLocation?.latitude ?? '-------'}',
                style: const TextStyle(fontSize: 18, color: Colors.purple),
              ),
              Text(
                'Longitude: ${currentLocation?.longitude ?? "-------"}',
                style: const TextStyle(fontSize: 18, color: Colors.purple),
              ),
            ],
          ),
        if (_errorMessage == null && currentLocation == null)
          const CircularProgressIndicator.adaptive(),
      ],
    ));
  }
}
