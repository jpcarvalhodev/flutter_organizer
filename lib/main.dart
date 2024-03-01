import 'package:flutter/material.dart';
import 'package:flutter_organizer/screen/first_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirstScreen()
    );
  }
}