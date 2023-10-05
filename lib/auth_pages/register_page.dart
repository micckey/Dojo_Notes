import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojonotes/auth_pages/auth_provider.dart';
import 'package:dojonotes/configurations/customwidgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:dojonotes/views/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'login_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, this.switchAuthPageFunction});

  final Function()? switchAuthPageFunction;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //Obscure password
  bool obscurePassword = true;

  void toggleObscure() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  //Email error
  String emailError = '';

  //Password error
  String passwordError = '';

  // text controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future signUp() async {
    try {
      if (_firstNameController.text.trim() != '' ||
          _lastNameController.text.trim() != '' ||
          _emailController.text.trim() != '' ||
          _passwordController.text.trim() != '') {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim());

        String userId = userCredential.user!.uid;

        addUserDetails(userId, _firstNameController.text.trim(),
            _lastNameController.text.trim(), _emailController.text.trim());

        Get.to(() => const AuthProvider());
      } else {
        buildSnackBar(
            'Error!!', 'Please fill in all fields then try again', CustomColors().alertText);
      }
    } catch (e) {
      print('THE ERROR MESSAGE IS::: ${e.toString()}');
      if (e.toString() ==
          '[firebase_auth/channel-error] Unable to establish connection on channel.') {
        buildSnackBar('Register Failed!!',
            'Error connecting to the internet, please check your connection!', CustomColors().alertText);
      } else if (e
          .toString()
          .contains('[firebase_auth/email-already-in-use]')) {
        setState(() {
          emailError = 'Bummer! The email you entered is already taken.';
        });
      } else if (e.toString().contains('[firebase_auth/invalid-email]')) {
        setState(() {
          emailError = 'Please enter a valid email address';
        });
      } else if (e.toString().contains('[firebase_auth/weak-password]')) {
        setState(() {
          passwordError = e.toString().substring(29);
        });
      } else {
        buildSnackBar('Register Failed', e, CustomColors().alertText);
      }
    }
  }

  Future addUserDetails(
      String userId, String firstName, String lastName, String email) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set({'first name': firstName, 'last name': lastName, 'email': email});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              myTextWidget('WELCOME TO OUR APP', 30.0, FontWeight.w800,
                  CustomColors().titleText),
              myTextWidget('REGISTER BELOW TO PROCEED', 20.0, FontWeight.w500,
                  CustomColors().titleText),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                child: myTextField(_firstNameController, 'First Name',
                    CustomColors().highlightColor),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                child: myTextField(_lastNameController, 'Last Name',
                    CustomColors().highlightColor),
              ),
              emailError == ''
                  ? const SizedBox.shrink()
                  : Center(
                      child: myTextWidget(
                          emailError, 15.sp, FontWeight.w400, Colors.redAccent),
                    ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                child: myTextField(
                    _emailController, 'Email', CustomColors().highlightColor),
              ),
              passwordError == ''
                  ? const SizedBox.shrink()
                  : Center(
                      child: myTextWidget(passwordError, 15.sp, FontWeight.w400,
                          Colors.redAccent),
                    ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                child: myPasswordField(
                    _passwordController,
                    'Password',
                    obscurePassword,
                    () => toggleObscure(),
                    CustomColors().highlightColor),
              ),
              GestureDetector(
                onTap: () => signUp(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.maxFinite,
                    height: 60,
                    color: CustomColors().buttonColor,
                    child: Center(
                        child: myTextWidget('Sign Up', 30.0, FontWeight.w500)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myTextWidget('Already have an account?', 16.sp,
                      FontWeight.w500, CustomColors().titleText),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: widget.switchAuthPageFunction,
                      child: myTextWidget(
                          'Login', 20.sp, FontWeight.w500, Colors.blue)),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
