import 'package:dojonotes/configurations/customwidgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:dojonotes/views/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().BackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: 470.h,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 142.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.r),
                            bottomRight: Radius.circular(15.r)),
                        color: CustomColors().HighlightColor,
                      ),
                      child: Center(
                        child: Text(
                            'To help you keep track \n of techniques that need perfecting',
                            style: TextStyle(
                              fontSize: 20.sp,
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
                      height: 400.h,
                      color: CustomColors().CardColor,
                      child: Stack(children: <Widget>[
                        Positioned(
                          height: 250.h,
                          width: 400.w,
                          top: 15.h,
                          right: 5.w,
                          child: Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/icon.png'))),
                          ),
                        ),
                        Positioned(
                            child: Container(
                                margin: EdgeInsets.only(top: 150.h),
                                child: Center(
                                    child: Text(
                                      'DojoNotes',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 60.sp,
                                      ),
                                    ))))
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                color: CustomColors().BackgroundColor,
                child: TextField(
                  cursorColor: Colors.black,

                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: 'Enter username to proceed',
                      prefixIcon:
                      const Icon(Icons.person, color: Colors.black54),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: CustomColors().HighlightColor),
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
            ),
            SizedBox(height: 30.h,),
            SizedBox(
              width: 224.w,
              height: 50.h,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStatePropertyAll(CustomColors().ButtonColor),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                  ),
                  child: TextButton(
                      onPressed: () {
                        Get.to(const Dashboard());
                      },
                      child: myTextWidget('Get Started', 14.sp, FontWeight.w600))),
            )
          ],
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
      h - 100.h,
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
