import 'package:all_about_maps/Features/basic_map_setup_with_map_controller/basic_map_setup_with_controller.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
            )
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
