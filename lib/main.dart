import 'package:all_about_maps/Features/basic_map_setup_with_map_controller/basic_map_setup_with_controller.dart';
import 'package:all_about_maps/Features/clustering/maps_clustering.dart';
import 'package:all_about_maps/Features/geocoding/geocoding.dart';
import 'package:all_about_maps/Features/geolocator_&_location/geolocator_and_location_my_location.dart';
import 'package:all_about_maps/Features/map_circles/map_circles.dart';
import 'package:all_about_maps/Features/map_places_api/google_maps_search_using_api_places.dart';
import 'package:all_about_maps/Features/map_polygons/map_polygons.dart';
import 'package:all_about_maps/Features/map_polylines/map_polylines.dart';
import 'package:all_about_maps/Features/maps_custom_info_window/maps_custom_info_window.dart';
import 'package:all_about_maps/Features/open_street_maps/search_with_picking_location_using_open_street_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          "All About Maps",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            //Google maps Basic Setup with GoogleMapsController
            NavigatorButton(
              buttonTitle: 'All About ( Markers - MapController - Styles )',
              color: Colors.greenAccent,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            const GoogleMapsBasicSetupWithController()));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            //geocoding
            NavigatorButton(
              buttonTitle: 'Geocoding',
              color: Colors.greenAccent,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MapsGeoCoding()));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            //geolocator (current location)
            NavigatorButton(
              buttonTitle: 'Geolocator & Location',
              color: Colors.greenAccent,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MapsGeolocator()));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            //Places Api
            NavigatorButton(
              buttonTitle: 'Places Api',
              color: Colors.greenAccent,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            const GoogleMapsSearchUsingApiPlacesAndWebServicesPackage()));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            //maps circles
            NavigatorButton(
              buttonTitle: 'Circles',
              color: Colors.greenAccent,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MapsCircles()));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            //polygons
            NavigatorButton(
              buttonTitle: 'Polygons',
              color: Colors.greenAccent,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MapPolygons()));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            //polylines
            NavigatorButton(
              buttonTitle: 'Polylines',
              color: Colors.greenAccent,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MapPolylines()));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            //custom info window
            NavigatorButton(
              buttonTitle: 'Custom Info Window',
              color: Colors.greenAccent,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const MapCustomInfoWindow()));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            //Open Street Maps (Api)
            NavigatorButton(
              buttonTitle: 'Open Street Maps (Api)',
              color: Colors.greenAccent,
              onPressed: () async {
                if (context.mounted) {
                  await showDialog(
                    context: context,
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.red,
                        title: const Text(
                          "Search and picking using Street api",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      body: PickFromMap(
                          center: LatLong(37.7749, -122.4194),
                          zoomOutIcon: Icons.zoom_out,
                          zoomInIcon: Icons.zoom_in,
                          buttonText: 'Set Current Location',
                          onPicked: (pickedData) {
                            debugPrint(
                                ">>>>> this is picked Data ${pickedData.latLong.toString()}");
                          }),
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            //Tracking
            NavigatorButton(
              buttonTitle: 'Tracking',
              color: Colors.greenAccent,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MapPolygons()));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            //Clustering
            NavigatorButton(
              buttonTitle: 'Clustering',
              color: Colors.greenAccent,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MapsClustering()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NavigatorButton extends StatelessWidget {
  final Function() onPressed;
  final String buttonTitle;
  final Color color;
  const NavigatorButton(
      {super.key,
      required this.onPressed,
      required this.buttonTitle,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        ),
        child: Text(
          buttonTitle,
          style: const TextStyle(color: Colors.white),
        ));
  }
}
