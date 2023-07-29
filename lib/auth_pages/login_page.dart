import 'package:dojonotes/auth_pages/register_page.dart';
import 'package:dojonotes/views/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../configurations/customwidgets.dart';
import '../configurations/style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      Get.to(() => const Dashboard());
    } catch (e) {
      print('THE ERROR MESSAGE IS::: ${e.toString()}');
      if (e.toString().contains('[firebase_auth/channel-error]')||e.toString().contains('[firebase_auth/network-request-failed]')
          ) {
        Get.snackbar('Login Failed!!',
            'Error connecting to the internet, please check your connection!',
            snackPosition: SnackPosition.TOP,
            backgroundColor: CustomColors().CardColor,
            animationDuration: const Duration(seconds: 2),);
      }else{
        Get.snackbar('Register Failed!!', '$e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().BackgroundColor,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            myTextWidget('WELCOME BACK', 30.0, FontWeight.w800,
                CustomColors().LightText),
            myTextWidget('LOGIN BELOW TO PROCEED', 20.0, FontWeight.w500,
                CustomColors().LightText),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
              child: myTextField(
                  _emailController, 'Email', CustomColors().HighlightColor),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
              child: myTextField(_passwordController, 'Password',
                  CustomColors().HighlightColor, 1, true),
            ),
            GestureDetector(
              onTap: () => signIn(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.maxFinite,
                  height: 60,
                  color: CustomColors().ButtonColor,
                  child: Center(
                      child: myTextWidget('Login', 30.0, FontWeight.w500)),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                myTextWidget('Don\'t have an account?', 16.sp, FontWeight.w500,
                    CustomColors().LightText),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(() => const RegisterScreen());
                    },
                    child: myTextWidget(
                        'Register', 20.sp, FontWeight.w500, Colors.blue)),
              ],
            )
          ],
        ),
      )),
    );
  }
}
