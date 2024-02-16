/* Geolocator :-
----------------
Geolocator Package:
-------------------
The geolocator package is a Flutter plugin that provides easy access to the device's location services, including retrieving 
the device's current location, monitoring location changes, and requesting permissions for location access.

Functionalities:
----------------
1- Get Current Location: Retrieve the device's current location (latitude and longitude).

2- Watch Position: Continuously monitor the device's location and receive updates as the location changes. (Using in tracking)

3- Check Service Availability: Check if location services are enabled on the device.

4- Request Permission: Request permission from the user to access the device's location.
   Check Permission Status: Check the current status of location permission.

Usage Example:
-------------

import 'package:geolocator/geolocator.dart';
    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    print('Current Location: ${position.latitude}, ${position.longitude}');

    // Watch for location changes
    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
    ).listen((Position position) {
      print('Updated Location: ${position.latitude}, ${position.longitude}');
    });

    // Stop listening to location changes
    positionStream.cancel();


*/