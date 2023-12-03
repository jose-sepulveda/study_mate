import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_mate/provider/calendar_state.dart';
import 'package:study_mate/views/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CalendarState(),
      child: const MyApp(),
    ),
  );
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
