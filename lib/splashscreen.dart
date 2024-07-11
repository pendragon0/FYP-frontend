import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:projm/slider.dart';


class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlutterSplashScreen.fadeIn(backgroundColor: Colors.white ,childWidget: SizedBox(height: 200, width: 200, child: Image.asset("assets/medsscan_logo1.png")), nextScreen: const SliderScreen(),),
    );
  }
}