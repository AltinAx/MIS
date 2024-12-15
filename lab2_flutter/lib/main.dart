import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(JokeApp());

class JokeApp extends StatelessWidget {
  const JokeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}