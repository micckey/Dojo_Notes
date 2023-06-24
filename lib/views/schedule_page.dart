import 'package:dojonotes/configurations/style.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 350,
        backgroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: CustomColors().HighlightColor,
            borderRadius: BorderRadius.circular(30)
          ),
        ),
      ),
    );
  }
}
