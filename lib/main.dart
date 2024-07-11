import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projm/splashscreen.dart'; 


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb){
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCo3c9avdHV7jMHuOEMkQzFGpZnC6eh6qA",
        authDomain: "medscan-dbf32.firebaseapp.com",
        projectId: "medscan-dbf32",
        storageBucket: "medscan-dbf32.appspot.com",
        messagingSenderId: "424675848",
        appId: "1:424675848:web:8421ce74e15b6b5f7f9fbd",
      )
    );

  }

  else{
  try {
    // await Firebase.initializeApp();
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCD2mEu7aw9HQbeuk3PZ0PlgVQvHN9ht5k",
        authDomain: "medscan-dbf32.firebaseapp.com",
        projectId: "medscan-dbf32",
        storageBucket: "medscan-dbf32.appspot.com",
        messagingSenderId: "424675848",
        appId: "1:424675848:android:d8645d9b5ee600c37f9fbd",
        // measurementId: 'G-F1Q1MCVH9Z'
        )
      );
  print('app launched*****************');
  } catch (e) {
    print("Failed to initialize Firebase: $e");
  }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Splashscreen(),
    );}}