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
  String currentMapStyle = "first_style";
  List<String> mapStyleOptions = [
    "first_style",
    "second_style",
    "third_style",
    "forth_style",
    "fifth_style"
  ];

  List<DropdownMenuItem<int>>? styleOptions = [
    DropdownMenuItem<int>(
      key: UniqueKey(),
      onTap: () {},
      value: 2,
      child: const Text("Theme 2"),
    ),
    DropdownMenuItem<int>(
      key: UniqueKey(),
      onTap: () {},
      value: 3,
      child: const Text("Theme 3"),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        centerTitle: true,
        title: const Text(
          "Maps Basic Setup with Controller",
          style: TextStyle(color: Colors.white, fontSize: 16),
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
                CustomChip(
                  color: Colors.red,
                  title: "first",
                  onTap: () {},
                )
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
                  items: mapStyleOptions
                      .map(
                        (e) => DropdownMenuItem<String>(
                          key: UniqueKey(),
                          onTap: () {},
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
          Expanded(
            child: GoogleMap(
              onTap: (LatLng latLng) {
                // Do something when the map is tapped
              },
              onCameraMove: (CameraPosition position) {
                // Do something when the camera position changes
              },
              onMapCreated: (GoogleMapController controller) {
                // Do something when the map is created
                mapController = controller;
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(37.7749, -122.4194),
                zoom: 12,
              ),
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
