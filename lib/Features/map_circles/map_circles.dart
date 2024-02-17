import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class MapsCircles extends StatefulWidget {
  const MapsCircles({super.key});

  @override
  State<MapsCircles> createState() => _MapsCirclesState();
}

class _MapsCirclesState extends State<MapsCircles> {
  Set<Circle> circles = {};
  late GoogleMapController mapController;
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
          "Google Maps Circles",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          const Text("Tap on Map To Add Circles"),
          const SizedBox(
            height: 12,
          ),
          const Text(""),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: GoogleMap(
              circles: circles,
              onLongPress: (LatLng latLng) {
                // Do something when the map is long pressed
              },
              onTap: (LatLng latLng) {
                // Do something when the map is tapped
                setState(() {
                  circles.add(Circle(
                      circleId: CircleId(const Uuid().v4()),
                      center: latLng,
                      radius: 5000, // Radius in meters
                      fillColor: Colors.blue.withOpacity(0.3), // Fill color
                      strokeWidth: 2, // Stroke width
                      strokeColor: Colors.blue,
                      onTap: () {},
                      visible: true)); // Stroke color));
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
