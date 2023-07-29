import 'package:dojonotes/auth_pages/auth_provider.dart';
import 'package:dojonotes/views/onboardingpage.dart';
import 'package:dojonotes/views/stories_page.dart';
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
      theme: ThemeData(
        fontFamily: 'RobotoSlab'
      ),
      home: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final screenSize = constraints.biggest;
          return ScreenUtilInit(
            builder: (context, child) => const AuthProvider(),
            designSize: screenSize,
          );
        },
      ),
    );

  }
}
