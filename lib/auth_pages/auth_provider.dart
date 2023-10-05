import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:dojonotes/views/dashboard.dart';
import 'package:dojonotes/views/onboardingpage.dart';
import 'package:dojonotes/views/splash_screen.dart';
import 'package:dojonotes/views/stories_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../configurations/customwidgets.dart';
import '../models/user_model.dart';

class AuthProvider extends StatelessWidget {
  const AuthProvider({super.key});

  Future<UserModel?> getUserDetails(String userId) async {

    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
    await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if(userSnapshot.exists){
      Map<String, dynamic> userData = userSnapshot.data()!;
      return UserModel(firstName: userData['first name'], lastName: userData['last name'], email: userData['email']);
    }
    else{
      return null;
    }
    // return userSnapshot.data()!;
  }



  @override
  Widget build(BuildContext context) {

    //User Profile data
    String? firstName = '';
    String? lastName = '';
    String? email = '';

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData){

            //Get the current user authenticated
            final user = FirebaseAuth.instance.currentUser!;
            final String userID = user.uid;
            // final String token = user.getIdToken() as String;

            return FutureBuilder(future: getUserDetails(user.uid), builder: (context, snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.done) {
                if (snapshot.hasData && snapshot.data != null) {
                  // Data is available, access first name here.

                  firstName = snapshot.data?.firstName;
                  lastName = snapshot.data?.lastName;
                  email = snapshot.data?.email;

                  return Dashboard(userID: userID, firstName: firstName, lastName: lastName, email: email,);
                }
                else {
                  // Data not found or an error occurred.
                  return Container(color: CustomColors().alertText,);
                }
              }  else {
                return const SplashScreen();
              }
            },);
          }else{
            return const StoriesPage();
          }
        },
      ),
    );
  }
}
