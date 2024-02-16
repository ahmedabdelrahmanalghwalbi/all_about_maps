import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationServices {
  LocationServices._();

  static final Location _location = Location();
  //get location with Location package
  static Future<LocationData?> getLocationViaLocationPackage() async {
    try {
      // Check if location service is enabled
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          return null;
        }
      }

      // Check location permission
      PermissionStatus permissionStatus = await _location.hasPermission();
      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await _location.requestPermission();
        if (permissionStatus != PermissionStatus.granted) {
          return null;
        }
      }

      // Get the current location
      return await _location.getLocation();
    } catch (e) {
      debugPrint('Error getting location via Location Package: $e');
      return null;
    }
  }

  // To receive location when application is in background you have to enable it:
  static void enableBackgroundLocation() {
    _location.enableBackgroundMode(enable: true);
  }
}
