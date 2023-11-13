import 'package:flutter/material.dart';
import 'package:study_mate/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'StudyMate',
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
