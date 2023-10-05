import 'package:dojonotes/auth_pages/auth_provider.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:dojonotes/views/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _provideAuth();
  }

  _provideAuth () async {
    await Future.delayed(const Duration(milliseconds: 3200));
    Get.to(()=>const AuthProvider());
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingScreen();
  }
}
