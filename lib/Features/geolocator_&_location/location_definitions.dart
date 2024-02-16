/* Location :-
-------------
Location Package:
----------------
The location package is another Flutter plugin for accessing the device's location services.
It provides similar functionalities to the geolocator package but has a different API design.

Functionalities:
----------------
1- Get Current Location: Retrieve the device's current location (latitude and longitude).
2- Watch Position: Continuously monitor the device's location and receive updates as the location changes.
3- Check Service Availability: Check if location services are enabled on the device.
4- Request Permission: Request permission from the user to access the device's location.
5- Check Permission Status: Check the current status of location permission.

Usage Example:
-------------
import 'package:location/location.dart';

    // Initialize the location service
    Location location = Location();

    // Check if location service is enabled
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Check location permission
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return;
      }
    }

    // Get the current location
    LocationData locationData = await location.getLocation();
    print('Current Location: ${locationData.latitude}, ${locationData.longitude}');

    // Listen for location changes
    location.onLocationChanged.listen((LocationData currentLocation) {
      print('Updated Location: ${currentLocation.latitude}, ${currentLocation.longitude}');
    });

*/