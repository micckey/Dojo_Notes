import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojonotes/configurations/customwidgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:dojonotes/views/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'login_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  //Obscure password
  bool obscurePassword=true;
  void toggleObscure(){
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
    try{
      if(_firstNameController.text.trim()!=''|| _lastNameController.text.trim()!=''||
    _emailController.text.trim()!=''||_passwordController.text.trim()!=''){
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());

        String userId = userCredential.user!.uid;

        addUserDetails(
            userId,
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            _emailController.text.trim());

        Get.to(()=> const Dashboard());
      }else{
        Get.snackbar('Register Failed!!',
          'Please fill in all fields then try again',
          snackPosition: SnackPosition.TOP,
          backgroundColor: CustomColors().CardColor,
          animationDuration: const Duration(seconds: 2),);
      }

    } catch (e){
      print('THE ERROR MESSAGE IS::: ${e.toString()}');
      if (e.toString() ==
          '[firebase_auth/channel-error] Unable to establish connection on channel.') {
        Get.snackbar('Register Failed!!',
          'Error connecting to the internet, please check your connection!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: CustomColors().CardColor,
          animationDuration: const Duration(seconds: 2),);
      }else if(e.toString().contains('[firebase_auth/email-already-in-use]')){
        setState(() {
          emailError = 'Bummer! The email you entered is already taken.';
        });
      }else if(e.toString().contains('[firebase_auth/invalid-email]')){
        setState(() {
          emailError = 'Please enter a valid email address';
        });}
      else if(e.toString().contains('[firebase_auth/weak-password]')){
        setState(() {
          passwordError = e.toString().substring(29);
        });
      }
      else{
        Get.snackbar('Register Failed!!', '$e');
      }
    }

  }

  Future addUserDetails(String userId, String firstName, String lastName, String email) async {
    await FirebaseFirestore.instance
        .collection('users').doc(userId).set({'first name': firstName, 'last name': lastName, 'email': email});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().BackgroundColor,
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              myTextWidget('WELCOME TO OUR APP', 30.0, FontWeight.w800,
                  CustomColors().LightText),
              myTextWidget('REGISTER BELOW TO PROCEED', 20.0, FontWeight.w500,
                  CustomColors().LightText),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                child: myTextField(_firstNameController, 'First Name',
                    CustomColors().HighlightColor),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                child: myTextField(_lastNameController, 'Last Name',
                    CustomColors().HighlightColor),
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
                onTap: () => signUp(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.maxFinite,
                    height: 60,
                    color: CustomColors().ButtonColor,
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
                  myTextWidget('Already have an account?', 16.sp, FontWeight.w500,
                      CustomColors().LightText),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(() => const LoginScreen());
                      },
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
