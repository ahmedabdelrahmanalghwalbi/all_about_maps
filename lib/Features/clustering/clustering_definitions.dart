/* CLUSTERING

Clustering is a technique used to group nearby markers together on a map to improve performance and readability. In Flutter,
you can implement clustering in Google Maps using the flutter_google_maps package along with plugins 
like flutter_map_cluster or google_maps_flutter_cluster.
Here's an overview of how to implement clustering in Flutter Google Maps with examples:


1-Add Dependencies:-
-------------------
dependencies:
  flutter:
    sdk: flutter
  google_maps_flutter: ^2.1.1
  google_maps_cluster_manager: ^0.3.0


2-Create Marker Data :-
-----------------------
Prepare your marker data, which typically includes latitude, longitude, and other relevant information for each marker.


3- Implement Clustering :-
------------------------
Use the clustering plugin to group nearby markers together. Here's an example implementation using google_maps_cluster_manager:



import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ClusterMapPage(),
    );
  }
}

class ClusterMapPage extends StatelessWidget {
  final LatLng _center = const LatLng(37.7749, -122.4194); // San Francisco coordinates
  final Set<Marker> _markers = Set();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map with Clustering'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _center, zoom: 10),
        markers: _markers,
        clusterManager: _createClusterManager(),
      ),
    );
  }

  ClusterManager<Marker> _createClusterManager() {
    return ClusterManager<Marker>(
      _markers,
      () async {
        // Add your marker data here
        List<Marker> markers = [
          Marker(
            markerId: MarkerId('1'),
            position: LatLng(37.7749, -122.4194),
          ),
          Marker(
            markerId: MarkerId('2'),
            position: LatLng(37.7751, -122.4185),
          ),
          // Add more markers...
        ];
        return markers;
      },
      markerBuilder: _markerBuilder,
      initialZoom: 10,
    );
  }

  Widget _markerBuilder(BuildContext context, Marker marker) {
    return Marker(
      markerId: marker.markerId,
      position: marker.position,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      onTap: () {
        // Handle marker tap
      },
    );
  }
}
*/