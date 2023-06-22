import 'package:flutter/material.dart';

class NewNote extends StatelessWidget {
  const NewNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('ADD NOTE')),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        toolbarHeight: 80,

      ),
    );
  }
}
