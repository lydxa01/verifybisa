import 'package:uas_traveleasy/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uas_traveleasy/resources/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:uas_traveleasy/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Splash(),
    );
  }
}
