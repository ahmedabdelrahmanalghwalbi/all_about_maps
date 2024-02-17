import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class WatchMyLocationInStreamByUsingGeolocator extends StatefulWidget {
  const WatchMyLocationInStreamByUsingGeolocator({super.key});

  @override
  State<WatchMyLocationInStreamByUsingGeolocator> createState() =>
      _WatchMyLocationInStreamByUsingGeolocatorState();
}

class _WatchMyLocationInStreamByUsingGeolocatorState
    extends State<WatchMyLocationInStreamByUsingGeolocator> {
  String? _errorMessage;
  Position? _currentPosition;
  StreamSubscription<Position>? _positionStreamSubscription;
  LocationSettings? locationSettings;
  int distanceFilter = 1;
  Duration intervalDuration = const Duration(seconds: 10);

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  @override
  void dispose() {
    super.dispose();
    _positionStreamSubscription?.cancel();
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    //it must always becouse i track changes even if the application is not use
    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      // Handle permission denial
      debugPrint('Background location permission denied');
    } else {
      // Permission granted, start listening for location updates
      //first define the location Settings depends on the Platform
      defineLocationServiceDependsOnPlatform();
      //then intialize Geolocator Subscription depends on the settings
      _initGeolocator();
    }
  }

  //In certain situation it is necessary to specify some platform specific settings. This can be accomplished using the platform specific
// AndroidSettings or AppleSettings classes. When using a platform specific class, the platform specific package must be imported as well.
// For example:
  void defineLocationServiceDependsOnPlatform() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: distanceFilter,
          forceLocationManager: true,
          intervalDuration: intervalDuration,
          //(Optional) Set foreground notification config to keep the app alive
          //when going to the background
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationText:
                "Example app will continue to receive your location even when you aren't using it",
            notificationTitle: "Running in Background",
            enableWakeLock: true,
          ));
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: distanceFilter,
        pauseLocationUpdatesAutomatically: true,
        // Only set to true if our app will be started up in the background.
        showBackgroundLocationIndicator: false,
      );
    } else {
      locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: distanceFilter,
      );
    }
  }

  Future<void> _initGeolocator() async {
    try {
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _errorMessage = null;
        _currentPosition = position;
      });
      _positionStreamSubscription =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((Position position) {
        setState(() {
          _errorMessage = null;
          _currentPosition = position;
        });
      }, onError: (error) async {
        _errorMessage = error.toString();
        //Returns the last known position stored on the users device.
        _currentPosition = await Geolocator.getLastKnownPosition();
        setState(() {});
      });
    } catch (e) {
      _errorMessage = e.toString();
      //Returns the last known position stored on the users device.
      _currentPosition = await Geolocator.getLastKnownPosition();
      setState(() {});
    }
  }

  Future<void> handlePermissionDenied() async {
    // Display a dialog explaining why location permissions are required
    // and provide a button to navigate to app settings to enable permissions
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

    // If the user chooses to go to settings, open app settings
    if (goToSettings) {
      await launchAppSettings();
    }
  }

  Future<void> launchAppSettings() async {
    // Launch app settings page to enable permissions manually
    await Geolocator.openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Watch My Current Location Stream Using Geolocator :-",
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        if (_errorMessage != null)
          Text(
            'Error: $_errorMessage',
            style: const TextStyle(color: Colors.red),
          ),
        if (_currentPosition != null)
          Column(
            children: [
              Text(
                'Latitude: ${_currentPosition?.latitude}',
                style: const TextStyle(fontSize: 18, color: Colors.blue),
              ),
              Text(
                'Longitude: ${_currentPosition?.longitude}',
                style: const TextStyle(fontSize: 18, color: Colors.blue),
              ),
            ],
          ),
        if (_errorMessage == null && _currentPosition == null)
          const CircularProgressIndicator.adaptive(),
      ],
    ));
  }
}
