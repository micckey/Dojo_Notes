import 'package:dojonotes/configurations/style.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ClipPath(
          clipper: CustomClipPath(),
          child: Container(
            width: double.infinity,
            height: 400,
            color: CustomColors().BackgroundColor,
            child: Stack(children: <Widget>[
              Positioned(
                height: 250,
                width: 400,
                top: 5,
                right: 5,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/icon.png'))),
                ),
              ),
              Positioned(
                  child: Container(
                    margin: EdgeInsets.only(top: 150),
                      child: Center(
                          child: Text('DojoNotes'))))
            ]),
          ),
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();

    path.lineTo(0, h);
    path.quadraticBezierTo(
      w * 0.5,
      h - 100,
      w,
      h,
    );
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
