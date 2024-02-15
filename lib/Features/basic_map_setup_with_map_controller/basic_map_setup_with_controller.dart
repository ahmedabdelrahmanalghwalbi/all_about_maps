import 'package:all_about_maps/Features/basic_map_setup_with_map_controller/map_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsBasicSetupWithController extends StatefulWidget {
  const GoogleMapsBasicSetupWithController({super.key});

  @override
  State<GoogleMapsBasicSetupWithController> createState() =>
      _GoogleMapsBasicSetupWithControllerState();
}

class _GoogleMapsBasicSetupWithControllerState
    extends State<GoogleMapsBasicSetupWithController> {
  late GoogleMapController mapController;
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.4219999, -122.0840575),
    zoom: 7,
  );
  String? currentMapStyle;

  //Set of markers
  Set<Marker> markers = {};
  //another way to add markers or any thing
  // controller.addMarker(
  // MarkerOptions(
  //   position: LatLng(37.7749, -122.4194),
  //   infoWindowText: InfoWindowText('Marker Title', 'Marker Description'),
  // ),);
  //Set of polygons
  Set<Polygon> polygons = {};
  //Set of polylines
  Set<Polyline> polylines = {};
  //Set of Circle
  Set<Circle> circles = {};
  //Set of TileOverlays
  Set<TileOverlay> tileOverlays = {};
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
          "Maps Markers with MapController with Styles",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            width: MediaQuery.sizeOf(context).width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                /// VERY [important] , i will use this feature to get the current boundrey to make any boundrey that i want
                /// by passing the current bountry to the GoogleMap() property [cameraTargetBounds]
                //You can retrieve the bounds of the currently visible region on the map using the getVisibleRegion method.
                CustomChip(
                  color: Colors.black,
                  title:
                      "retrieve the bounds of the currently visible region on the map",
                  onTap: () async {
                    LatLngBounds visibleRegion =
                        await mapController.getVisibleRegion();
                    debugPrint(
                        " very important Feature to get the current boundary [any boundary i want ] to parse it to GoogleMap() property [cameraTargetBounds] to make boundaries to may Map ${visibleRegion.northeast} === ${visibleRegion.southwest}");
                  },
                ),
                CustomChip(
                  color: Colors.red,
                  title: "move camera to specific position",
                  onTap: () {
                    mapController.moveCamera(
                      CameraUpdate.newLatLngZoom(
                          const LatLng(37.7749, -122.4194), 12.0),
                    );
                  },
                ),
                CustomChip(
                  color: Colors.green,
                  title: "animate camera to specific position",
                  onTap: () {
                    mapController.animateCamera(
                      CameraUpdate.newLatLngZoom(
                          const LatLng(37.7749, -122.4194), 12.0),
                    );
                  },
                ),
                CustomChip(
                  color: Colors.black,
                  title:
                      "convert a point on the screen to geographical coordinates",
                  onTap: () async {
                    LatLng position = await mapController.getLatLng(
                      const ScreenCoordinate(x: 100, y: 100),
                    );
                    debugPrint(
                        "this is screen coordinates in Latlng after transformatting from coordinates to Latlng $position");
                  },
                ),
                CustomChip(
                  color: Colors.black,
                  title: "convert geographical coordinates to a point ",
                  onTap: () async {
                    ScreenCoordinate screenCoordinate =
                        await mapController.getScreenCoordinate(
                      const LatLng(37.7749, -122.4194),
                    );
                    debugPrint(
                        "this is screen coordinates after transformatting from Latlng to Coordinates $screenCoordinate");
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                  underline: Container(
                    // Customize the underline
                    height: 2,
                    color: Colors.red,
                  ),
                  style: const TextStyle(color: Colors.red, fontSize: 18.0),
                  value: currentMapStyle,
                  icon: const Icon(
                    Icons.arrow_circle_down,
                    color: Colors.red,
                  ),
                  items: mapsStyles.keys
                      .map(
                        (e) => DropdownMenuItem<String>(
                          key: UniqueKey(),
                          onTap: () {
                            setState(() {
                              mapController.setMapStyle(mapsStyles[e]);
                              currentMapStyle = e;
                            });
                          },
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                  onChanged: (String? currentStyle) {
                    setState(() {
                      currentMapStyle = currentStyle ?? "first_style";
                    });
                  })
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          const Text("Current Camera Position:-"),
          const SizedBox(
            height: 12,
          ),
          Text(
              "${cameraPosition.target.latitude} == ${cameraPosition.target.longitude}"),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: GoogleMap(
              onLongPress: (LatLng latLng) {
                // Do something when the map is long pressed
              },
              onTap: (LatLng latLng) {
                // Do something when the map is tapped
                setState(() {
                  markers.add(Marker(
                      markerId:
                          MarkerId("${latLng.latitude + latLng.longitude}"),
                      //Geographical location of the marker.
                      position: latLng,
                      // The opacity of the marker, between 0.0 and 1.0 inclusive.
                      alpha: 0.5,
                      // True if the marker is visible.
                      visible: true,
                      // Callbacks to receive tap events for markers placed on this map.
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
                              marker =
                                  marker.copyWith(positionParam: newLatlng);
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
                      rotation: 40,
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
                      anchor: const Offset(0.0, 0.0)));
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
              markers: markers,
              polygons: polygons,
              polylines: polylines,
              circles: circles,
              // Tile overlays to be placed on the map.
              tileOverlays: tileOverlays,
              initialCameraPosition: cameraPosition,
              //Called when the camera starts moving.
              onCameraMoveStarted: () {},
              //Called when camera movement has ended, there are no pending animations and the user has stopped interacting with the map.
              onCameraIdle: () {},
              //Enables or disables showing 3D buildings where available
              buildingsEnabled: true,
              // Geographical bounding box for the camera target.
              // Creates a camera target bounds with the specified bounding box, or null to indicate that the camera target is not bounded.
              //تسمح لك بتعريف حدود لموقع الكاميرا. يقيد قدرة المستخدم على التحريك خارج الحدود المحددة.
              // default value
              // cameraTargetBounds: CameraTargetBounds.unbounded,
              // cameraTargetBounds: CameraTargetBounds(
              //   LatLngBounds(
              //     southwest: const LatLng(37.0, -123.0),
              //     northeast: const LatLng(38.0, -121.0),
              //   ),
              // ),
              //Type of map tiles to be rendered.
              mapType: MapType.normal,
              //Enables or disables the traffic layer of the map
              trafficEnabled: true,
              //Enables or disables the my-location button.
              myLocationButtonEnabled: true,
              //True if a "My Location" layer should be shown on the map.
              myLocationEnabled: true,
              //True if the map view should show zoom controls. This includes two buttons to zoom in and zoom out. The default value is to show zoom controls.
              zoomControlsEnabled: true,
              //True if the map view should respond to zoom gestures.
              zoomGesturesEnabled: true,
              //Enables or disables the indoor view from the map
              indoorViewEnabled: true,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomChip extends StatelessWidget {
  final String title;
  final Function() onTap;
  final Color color;
  const CustomChip(
      {required this.color,
      required this.onTap,
      required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: onTap,
        child: Chip(
          label: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: color,
        ),
      ),
    );
  }
}
