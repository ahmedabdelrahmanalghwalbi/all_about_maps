import 'package:all_about_maps/Features/geolocator_&_location/services/geolocator_services.dart';
import 'package:all_about_maps/Features/geolocator_&_location/services/location_services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';

class MapsGeolocator extends StatefulWidget {
  const MapsGeolocator({super.key});

  @override
  State<MapsGeolocator> createState() => _MapsGeolocatorState();
}

class _MapsGeolocatorState extends State<MapsGeolocator> {
  Set<Marker> markers = {};
  late GoogleMapController mapController;
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.4219999, -122.0840575),
    zoom: 7,
  );

  @override
  void initState() {
    super.initState();

    // To receive location when application is in background you have to enable it:
    LocationServices.enableBackgroundLocation();
  }

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
          "Geolocator and Location",
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
            "Watch My Current Location Stream Using Geolocator :-",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 6,
          ),
          const Text(
            "",
            style: TextStyle(
                color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Watch My Current Location Stream Using Location :-",
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "",
            style: TextStyle(
                color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: GoogleMap(
              markers: markers,
              onMapCreated: (GoogleMapController controller) {
                // Do something when the map is created
                mapController = controller;
              },
              initialCameraPosition: cameraPosition,
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //GET CURRENT LOCATION USING (LOCATION PACKAGE)
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      //first get my location using Location Package
                      LocationData? myCurrentLocationData =
                          await LocationServices
                              .getLocationViaLocationPackage();
                      if (myCurrentLocationData == null ||
                          myCurrentLocationData.longitude == null ||
                          myCurrentLocationData.latitude == null) return;
                      //second Add Marker To my location
                      setState(() {
                        markers.add(Marker(
                            markerId: MarkerId(const Uuid().v4()),
                            //Geographical location of the marker.
                            position: LatLng(myCurrentLocationData.latitude!,
                                myCurrentLocationData.longitude!),
                            // Callbacks to receive tap events for markers placed on this map.
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return AlertDialog(
                                    title: Text(
                                        'Hi Im Marker with Id ${myCurrentLocationData.latitude! + myCurrentLocationData.longitude!}'),
                                    content: Text(
                                        "i'm marker who placed in ${myCurrentLocationData.latitude} -- ${myCurrentLocationData.longitude}"),
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
                            infoWindow: const InfoWindow(
                                title: "my location (Location Package)",
                                snippet: " YES !!!")));
                      });

                      //finally, animated to my location marker
                      mapController.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                              target: LatLng(myCurrentLocationData.latitude!,
                                  myCurrentLocationData.longitude!),
                              zoom: 16)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.all(8),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            "my location (Location Package)",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              //GET CURRENT LOCATION USING (GEOLOCATOR)
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      //first get my location using geolocator Package
                      Position? myCurrentLocationData =
                          await GeolocatorServices.getCurrentLocation();
                      if (myCurrentLocationData == null) return;
                      //second Add Marker To my location
                      setState(() {
                        markers.add(Marker(
                            markerId: MarkerId(const Uuid().v4()),
                            //Geographical location of the marker.
                            position: LatLng(myCurrentLocationData.latitude,
                                myCurrentLocationData.longitude),
                            // Callbacks to receive tap events for markers placed on this map.
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return AlertDialog(
                                    title: Text(
                                        'Hi Im Marker with Id ${myCurrentLocationData.latitude + myCurrentLocationData.longitude}'),
                                    content: Text(
                                        "i'm marker who placed in ${myCurrentLocationData.latitude} -- ${myCurrentLocationData.longitude}"),
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
                            infoWindow: const InfoWindow(
                                title: "my location (Geolocator Package)",
                                snippet: " YES !!!")));
                      });

                      //finally, animated to my location marker
                      mapController.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                              target: LatLng(myCurrentLocationData.latitude,
                                  myCurrentLocationData.longitude),
                              zoom: 16)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.all(8),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            "my location (Geolocator Package)",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
