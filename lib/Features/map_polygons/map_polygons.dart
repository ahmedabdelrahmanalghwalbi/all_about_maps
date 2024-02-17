import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPolygons extends StatefulWidget {
  const MapPolygons({super.key});

  @override
  State<MapPolygons> createState() => _MapPolygonsState();
}

class _MapPolygonsState extends State<MapPolygons> {
  Set<Marker> markers = {};
  List<LatLng> polygonPoints = [
    const LatLng(37.7749, -122.4194),
    const LatLng(37.7850, -122.4074),
    const LatLng(37.7739, -122.4037),
  ];
  late GoogleMapController mapController;
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.4219999, -122.0840575),
    zoom: 7,
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
          "Polygons",
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
              "Make Polygon , darg and drop markers to change your polygon"),
          const SizedBox(
            height: 12,
          ),
          const Text(""),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: GoogleMap(
              markers: markers,
              polygons: {
                Polygon(
                  polygonId: const PolygonId('polygon_1'),
                  points: polygonPoints,
                  fillColor: Colors.black, // Fill color
                  strokeColor: Colors.blue, // Stroke color
                  strokeWidth: 100, // Stroke width
                  geodesic: true, // Geodesic or straight line
                ),
              },
              onLongPress: (LatLng latLng) {
                // Do something when the map is long pressed
              },
              onTap: (LatLng latLng) {
                // Do something when the map is tapped
                markers.add(Marker(
                  markerId: MarkerId("${latLng.latitude + latLng.longitude}"),
                  //Geographical location of the marker.
                  position: latLng,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext ctx) {
                        return AlertDialog(
                          title: Text(
                              'Hi Im Marker with Id ${latLng.latitude + latLng.longitude}'),
                          content: Text(
                              "i'm marker who placed in ${latLng.latitude} -- ${latLng.longitude}"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // Close the dialog when this button is pressed
                                Navigator.of(ctx).pop();
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  draggable: true,
                  //Signature reporting the new [LatLng] during the drag event.
                  onDrag: (LatLng newLatlng) {
                    markers.map((marker) {
                      if (marker.markerId.value ==
                          "${latLng.latitude + latLng.longitude}") {
                        setState(() {
                          marker = marker.copyWith(positionParam: newLatlng);
                        });
                      }
                    });
                  },
                  // Signature reporting the new [LatLng] at the start of a drag event.
                  onDragStart: (latlang) {},
                  // Signature reporting the new [LatLng] at the start of a drag event.
                  onDragEnd: (latlng) {
                    setState(() {
                      polygonPoints.add(latLng);
                    });
                  },
                ));

                setState(() {});
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
                //set Markers on Polygon vertics
                polygonPoints.map((latlng) {
                  markers.add(Marker(
                    markerId: MarkerId("${latlng.latitude + latlng.longitude}"),
                    //Geographical location of the marker.
                    position: latlng,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            title: Text(
                                'Hi Im Marker with Id ${latlng.latitude + latlng.longitude}'),
                            content: Text(
                                "i'm marker who placed in ${latlng.latitude} -- ${latlng.longitude}"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // Close the dialog when this button is pressed
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    draggable: true,
                    //Signature reporting the new [LatLng] during the drag event.
                    onDrag: (LatLng newLatlng) {
                      markers.map((marker) {
                        if (marker.markerId.value ==
                            "${newLatlng.latitude + newLatlng.longitude}") {
                          setState(() {
                            marker = marker.copyWith(positionParam: newLatlng);
                          });
                        }
                      });
                    },
                    // Signature reporting the new [LatLng] at the start of a drag event.
                    onDragStart: (latlang) {},
                    // Signature reporting the new [LatLng] at the start of a drag event.
                    onDragEnd: (latlng) {
                      setState(() {
                        polygonPoints.add(latlng);
                      });
                    },
                  ));
                });
                setState(() {});
              },
              initialCameraPosition: cameraPosition,
            ),
          ),
        ],
      ),
    );
  }
}
