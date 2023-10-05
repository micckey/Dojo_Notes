import 'package:dojonotes/configurations/customwidgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String firstName = Get.arguments[0];
  String lastName = Get.arguments[1];
  String email = Get.arguments[2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: CustomColors().backgroundColor,
        title: myTextWidget('Edit Your Profile', 20.sp, FontWeight.w400,
            CustomColors().titleText),
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            CustomColors().backgroundColor.withOpacity(0.9),
            CustomColors().cardColor.withOpacity(0.95)
          ], begin: Alignment.topLeft, end: Alignment.centerRight),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Icon(
            Icons.person,
            size: 100,
            color: CustomColors().titleText,
          ),
          const SizedBox(height: 20,),
          profilePageCard('First Name', firstName),
          const SizedBox(height: 30,),
          profilePageCard('Last Name', lastName),
          const SizedBox(height: 30,),
          profilePageCard('Email', email),
        ]),
      ),
    );
  }

  Column profilePageCard(title, content) {
    return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                myTextWidget(title, 16.sp, FontWeight.w400, CustomColors().titleText.withOpacity(0.7)),
                const SizedBox(width: 50,),
                GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.edit, color: CustomColors().titleText.withOpacity(0.9),))
              ],
            ),
            Container(
              width: double.maxFinite,
              height: 60,
              decoration: BoxDecoration(
                  color: CustomColors().highlightColor,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: myTextWidget(content, 23.sp, FontWeight.w500, CustomColors().titleText)),
            )
          ],
        );
  }
}
