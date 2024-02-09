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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("All About Maps"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Google maps Basic Setup with GoogleMapsController
            NavigatorButton(
              buttonTitle: 'Google Maps Basic Setup with Controller',
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
        child: Text(
          buttonTitle,
          style: TextStyle(color: color),
        ));
  }
}
