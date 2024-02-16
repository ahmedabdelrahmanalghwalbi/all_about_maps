import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorServices {
  const GeolocatorServices._();

  static Future<Position?> getCurrentLocation() async {
    LocationPermission permission = await _getLocationPermission();

    if (permission == LocationPermission.denied) {
      permission = await _requestLocationPermission();
    }

    if (permission == LocationPermission.denied) {
      debugPrint('Location permission denied');
      return null;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } catch (e) {
      debugPrint('Failed to get location: $e');
      return null;
    }
  }

  static Future<LocationPermission> _getLocationPermission() async {
    return await Geolocator.checkPermission();
  }

  static Future<LocationPermission> _requestLocationPermission() async {
    return await Geolocator.requestPermission();
  }
}
