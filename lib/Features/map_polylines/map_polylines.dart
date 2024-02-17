import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class MapPolylines extends StatefulWidget {
  const MapPolylines({super.key});

  @override
  State<MapPolylines> createState() => _MapPolylinesState();
}

class _MapPolylinesState extends State<MapPolylines> {
  late GoogleMapController mapController;
  List<LatLng> polylinePoints = [
    const LatLng(37.7749, -122.4194),
    const LatLng(37.7850, -122.4074),
    const LatLng(37.7739, -122.4037),
  ];
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.4219999, -122.0840575),
    zoom: 12,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        centerTitle: true,
        title: const Text(
          "PolyLines",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          const Text(
              "Polyline :- drawing line between provided list points of (lat,long)"),
          const SizedBox(
            height: 6,
          ),
          const Text("Draw Polyline By Tapping to Map"),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: GoogleMap(
              polylines: {
                Polyline(
                  polylineId: PolylineId(const Uuid().v4()),
                  points: polylinePoints,
                  color: Colors.red, // Polyline color
                  width: 10, // Polyline width
                  geodesic: true, // Geodesic or straight line
                ),
              },
              onLongPress: (LatLng latLng) {
                // Do something when the map is long pressed
              },
              onTap: (LatLng latLng) {
                // Do something when the map is tapped
                setState(() {
                  polylinePoints.add(latLng);
                });
              },
              onCameraMove: (CameraPosition position) {
                // Do something when the camera position changes
                setState(() {
                  cameraPosition = position;
                });
              },
              onMapCreated: (GoogleMapController controller) {
                // Do something when the map is created
                mapController = controller;
              },
              initialCameraPosition: cameraPosition,
            ),
          ),
        ],
      ),
    );
  }
}
