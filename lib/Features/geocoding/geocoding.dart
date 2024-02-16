import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsGeoCoding extends StatefulWidget {
  const MapsGeoCoding({super.key});

  @override
  State<MapsGeoCoding> createState() => _MapsGeoCodingState();
}

class _MapsGeoCodingState extends State<MapsGeoCoding> {
  Set<Marker> markers = {};
  late GoogleMapController mapController;
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.4219999, -122.0840575),
    zoom: 5,
  );

  String? addressAfterReverseGeocoding;
  //transform Address to coordinates
  Future<Placemark> getAddressAfterForwardGeocoding(
      {required LatLng latlng}) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
    return placemarks.first;
  }

  //tranform coordinates to Address
  Future<Location> getCoordinatesAfterReverseGeocoding(
      {required String address}) async {
    List<Location> locations = await locationFromAddress(address);
    return locations.first;
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
          "Geocoding",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          const Text(
              "After Creating Marker .. tap it to see it geocoding info"),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: GoogleMap(
              markers: markers,
              onLongPress: (LatLng latLng) {
                // Do something when the map is long pressed
              },
              onTap: (LatLng latLng) async {
                //first get Address after reverse geocoding

                // Do something when the map is tapped
                setState(() {
                  markers.add(Marker(
                    markerId: MarkerId("${latLng.latitude + latLng.longitude}"),
                    //Geographical location of the marker.
                    position: latLng,
                    // The opacity of the marker, between 0.0 and 1.0 inclusive.
                    // alpha: 0.5,
                    // True if the marker is visible.
                    visible: true,
                    // Callbacks to receive tap events for markers placed on this map.
                    onTap: () async {
                      Placemark placeMarkAfterGeoding =
                          await getAddressAfterForwardGeocoding(latlng: latLng);
                      if (context.mounted) {
                        showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return AlertDialog(
                              title: const Text(
                                  'Hi Im Marker, that is my Data After Reverse Geocoding :-'),
                              content: Column(
                                children: [
                                  //Street
                                  Row(
                                    children: [
                                      const Text("Street :"),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(placeMarkAfterGeoding.street ??
                                          "-----"),
                                    ],
                                  ),
                                  // locality
                                  Row(
                                    children: [
                                      const Text("locality :"),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(placeMarkAfterGeoding.locality ??
                                          "-----"),
                                    ],
                                  ),

                                  // sub-locality
                                  Row(
                                    children: [
                                      const Text("Sub-locality :"),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(placeMarkAfterGeoding.subLocality ??
                                          "-----"),
                                    ],
                                  ),
                                  //AdminstrativeArea
                                  Row(
                                    children: [
                                      const Text("Adminstrative Area :"),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(placeMarkAfterGeoding
                                              .administrativeArea ??
                                          "-----"),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      const Text("subAdministrativeArea :"),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(placeMarkAfterGeoding
                                              .subAdministrativeArea ??
                                          "-----"),
                                    ],
                                  ),
                                  //postal code
                                  Row(
                                    children: [
                                      const Text("Postal Code :"),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(placeMarkAfterGeoding.postalCode ??
                                          "-----"),
                                    ],
                                  ),
                                  //country
                                  Row(
                                    children: [
                                      const Text("Country :"),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(placeMarkAfterGeoding.country ??
                                          "-----"),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      const Text("isoCountryCode :"),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(placeMarkAfterGeoding
                                              .isoCountryCode ??
                                          "-----"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text("name :"),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(placeMarkAfterGeoding.name ??
                                          "-----"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text("thoroughfare :"),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(placeMarkAfterGeoding.thoroughfare ??
                                          "-----"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text("subThoroughfare :"),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(placeMarkAfterGeoding
                                              .subThoroughfare ??
                                          "-----"),
                                    ],
                                  ),
                                ],
                              ),
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
                      }
                    },
                    //The window is displayed when the marker is tapped.
                    infoWindow: InfoWindow(
                      title: "hi",
                      onTap: () {},
                      snippet: "im the marker !!!",
                    ),
                    //True if the marker is draggable by user touch events.
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
                    onDragEnd: (latlng) {},
                    //True if the marker is rendered flatly against the surface of the Earth, so that it will rotate and tilt along with map camera movements.
                    flat: true,
                    // Rotation of the marker image in degrees clockwise from the [anchor] point. start from 1 degree=> 360 degrees
                    // rotation: 40,
                    // A description of the bitmap used to draw the marker icon.
                    //change marker icon to be an image from assetrs
                    // icon: BitmapDescriptor.fromAssetImage(
                    //   //configration of image
                    //   ImageConfiguration(),
                    //   //path of the image
                    //    "image path")
                    //chnage marker icons from bytes
                    // icon: BitmapDescriptor.fromBytes(byteData)
                    //default Marker
                    icon: BitmapDescriptor.defaultMarker,
                    //True if the marker icon consumes tap events. If not, the map will perform default tap handling by centering the map on the marker and displaying its info window.
                    consumeTapEvents: true,
                    // The icon image point that will be placed at the [position] of the marker.
                    // anchor: const Offset(0.0, 0.0)
                  ));
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
