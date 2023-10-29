import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojonotes/auth_pages/login_page.dart';
import 'package:dojonotes/auth_pages/switch_auth_pages.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:dojonotes/views/dashboard.dart';
import 'package:dojonotes/views/splash_screen.dart';
import 'package:dojonotes/views/stories_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthProvider extends StatefulWidget {
  const AuthProvider({super.key});

  @override
  State<AuthProvider> createState() => _AuthProviderState();
}

class _AuthProviderState extends State<AuthProvider> {
  @override
  void initState() {

    super.initState();
    checkAuthStatus();
    getAuthToken();
  }

  User? currentUser;

  Future<void> checkAuthStatus() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      currentUser = user;
      IdTokenResult tokenResult = await user.getIdTokenResult();
      String authToken =
          tokenResult.token ?? ''; // Access the token as a String

      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('token', authToken);
    } else {
      // Handle the case where no user is signed in
      // Redirect to the login page or perform the desired action.
      Future.microtask(() {
        Get.to(() => const SwitchAuthPage(authPage: 'login'));
      });

    }
  }

  Future<UserModel?> getUserDetails(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userSnapshot.exists) {
      Map<String, dynamic> userData = userSnapshot.data()!;
      return UserModel(
          firstName: userData['first name'],
          lastName: userData['last name'],
          email: userData['email']);
    } else {
      return null;
    }
  }

  //Check if token exists
  String? userAuthToken = '';

  void getAuthToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    setState(() {
      userAuthToken = sharedPreferences.getString('token');
    });
  }

  @override
  Widget build(BuildContext context) {
    //User Profile data
    String? firstName = '';
    String? lastName = '';
    String? email = '';

    if (userAuthToken != '' && currentUser != null) {
      return FutureBuilder(
        future: getUserDetails(currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data != null) {
              // Data is available, access first name here.

              firstName = snapshot.data?.firstName;
              lastName = snapshot.data?.lastName;
              email = snapshot.data?.email;

              return Dashboard(
                userID: currentUser!.uid,
                firstName: firstName,
                lastName: lastName,
                email: email,
              );
            } else {
              // Data not found or an error occurred.
              return Container(
                color: CustomColors().alertText,
              );
            }
          } else {
            return const SplashScreen();
          }
        },
      );
    } else {
      return const StoriesPage();
    }
  }
}
