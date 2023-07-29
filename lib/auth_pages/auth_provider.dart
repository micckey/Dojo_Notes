import 'package:dojonotes/views/dashboard.dart';
import 'package:dojonotes/views/onboardingpage.dart';
import 'package:dojonotes/views/stories_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends StatelessWidget {
  const AuthProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData){
            return const Dashboard();
          }else{
            return const StoriesPage();
          }
        },
      ),
    );
  }
}
