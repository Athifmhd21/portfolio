import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/features/screens/homescreen.dart';
import 'package:portfolio/features/screens/foodiaQ.dart';
import 'package:portfolio/features/screens/grelasection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
