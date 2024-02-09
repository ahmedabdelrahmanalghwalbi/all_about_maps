import 'package:flutter/material.dart';

class GoogleMapsBasicSetupWithController extends StatefulWidget {
  const GoogleMapsBasicSetupWithController({super.key});

  @override
  State<GoogleMapsBasicSetupWithController> createState() =>
      _GoogleMapsBasicSetupWithControllerState();
}

class _GoogleMapsBasicSetupWithControllerState
    extends State<GoogleMapsBasicSetupWithController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maps Basic Setup with Controller"),
      ),
      body: const Center(
          child: Column(
        children: [],
      )),
    );
  }
}
