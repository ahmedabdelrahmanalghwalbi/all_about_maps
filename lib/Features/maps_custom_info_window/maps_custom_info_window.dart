import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class MapCustomInfoWindow extends StatefulWidget {
  const MapCustomInfoWindow({super.key});

  @override
  State<MapCustomInfoWindow> createState() => _MapCustomInfoWindowState();
}

class _MapCustomInfoWindowState extends State<MapCustomInfoWindow> {
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();

  final LatLng latLng = const LatLng(28.7041, 77.1025);
  final double _zoom = 15.0;

  @override
  void dispose() {
    customInfoWindowController.dispose();
    super.dispose();
  }

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Info Window Example'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          const Text("TAP ON MARKER TO REVIEW CISTOM INFO WINDOW"),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                GoogleMap(
                  onTap: (position) {
                    markers.add(
                      Marker(
                        markerId: MarkerId(const Uuid().v4()),
                        position: position,
                        onTap: () {
                          customInfoWindowController.addInfoWindow!(
                            Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.account_circle,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          Text(
                                            "I am here",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                ?.copyWith(
                                                  color: Colors.white,
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            position,
                          );
                        },
                      ),
                    );
                    setState(() {});
                    customInfoWindowController.hideInfoWindow!();
                  },
                  onCameraMove: (position) {
                    customInfoWindowController.onCameraMove!();
                  },
                  onMapCreated: (GoogleMapController controller) async {
                    customInfoWindowController.googleMapController = controller;
                  },
                  markers: markers,
                  initialCameraPosition: CameraPosition(
                    target: latLng,
                    zoom: _zoom,
                  ),
                ),
                CustomInfoWindow(
                  controller: customInfoWindowController,
                  height: 75,
                  width: 150,
                  offset: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
