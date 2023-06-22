import 'package:dojonotes/configurations/style.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: CustomColors().BackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 470,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 142,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          color: CustomColors().HighlightColor,
                        ),
                        child: const Center(
                          child: Text(
                              'To help you keep track \n of techniques that need perfecting',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: CustomClipPath(),
                      child: Container(
                        width: double.infinity,
                        height: 400,
                        color: CustomColors().CardColor,
                        child: Stack(children: <Widget>[
                          Positioned(
                            height: 250,
                            width: 400,
                            top: 15,
                            right: 5,
                            child: Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/icon.png'))),
                            ),
                          ),
                          Positioned(
                              child: Container(
                                  margin: const EdgeInsets.only(top: 150),
                                  child: const Center(
                                      child: Text(
                                    'DojoNotes',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 60,
                                    ),
                                  ))))
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Enter your Name below to proceed',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              // SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  color: CustomColors().BackgroundColor,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelText: 'username',
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: const Icon(Icons.person),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
              ),
              SizedBox(
                width: 224,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(CustomColors().ButtonColor),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                    ),
                    child: const Text('Get Started')),
              )
            ],
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
