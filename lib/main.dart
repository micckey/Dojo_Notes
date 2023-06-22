import 'package:dojonotes/configurations/style.dart';
import 'package:dojonotes/views/dashboard.dart';
import 'package:dojonotes/views/new_note.dart';
import 'package:dojonotes/views/onboardingpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'fair'),
      debugShowCheckedModeBanner: false,
      home: const Dashboard()
    );
  }
}

