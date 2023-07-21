import 'package:dojonotes/views/onboardingpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final screenSize = constraints.biggest;
          return ScreenUtilInit(
            builder: (context, child) => const OnboardingScreen(),
            designSize: screenSize,
          );
        },
      ),
    );

  }
}
