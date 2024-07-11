import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:projm/slider.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlutterSplashScreen.fadeIn(
        backgroundColor: Colors.white,
        childWidget: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/splashscreen1.png"), // Your background image with the logo
              fit: BoxFit.cover,
            ),
          ),
        ),
        nextScreen: const SliderScreen(),
      ),
    );
  }
}
