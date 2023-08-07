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

  //Obscure password
  bool obscurePassword=true;
  void toggleObscure(){
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  //User email error
  String emailError = '';

  //Password error
  String passwordError = '';

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
      if(_emailController.text.trim()!=''||_passwordController.text.trim()!=''){
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());

        Get.to(() => const Dashboard());
      }else{
        Get.snackbar('Login Failed!!',
          'Please fill in all fields then try again',
          snackPosition: SnackPosition.TOP,
          backgroundColor: CustomColors().CardColor,
          animationDuration: const Duration(seconds: 2),);
      }

    } catch (e) {
      print('THE ERROR MESSAGE IS::: ${e.toString()}');
      if (e.toString().contains('[firebase_auth/channel-error]')||e.toString().contains('[firebase_auth/network-request-failed]')
          ) {
        Get.snackbar('Login Failed!!',
            'Error connecting to the internet, please check your connection!',
            snackPosition: SnackPosition.TOP,
            backgroundColor: CustomColors().CardColor,
            animationDuration: const Duration(seconds: 2),);
      }else if(e.toString().contains('[firebase_auth/wrong-password]')){
        setState(() {
          passwordError = 'Incorrect password!!';
        });
      }
      else if(e.toString().contains('[firebase_auth/user-not-found]')){
        setState(() {
          emailError = 'The email you entered does not exist!!';
        });
      }else if(e.toString().contains('[firebase_auth/invalid-email]')){
        setState(() {
          emailError = 'Please enter a valid email address';
        });
      }
      else{
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
            emailError==''?const SizedBox.shrink():Center(child: myTextWidget(emailError, 15.sp, FontWeight.w400, Colors.redAccent), ),
            SizedBox(height: 5.h,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
              child: myTextField(
                  _emailController, 'Email', CustomColors().HighlightColor),
            ),
            passwordError==''?const SizedBox.shrink():Center(child: myTextWidget(passwordError, 15.sp, FontWeight.w400, Colors.redAccent), ),
            SizedBox(height: 5.h,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
              child: myPasswordField(_passwordController, 'Password', obscurePassword, ()=>toggleObscure(),CustomColors().HighlightColor),
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
