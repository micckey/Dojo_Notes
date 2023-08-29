import 'package:dojonotes/configurations/customwidgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: CustomColors().BackgroundColor,
        title: myTextWidget('Edit Your Profile', 20.sp, FontWeight.w400,
            CustomColors().LightText),
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            CustomColors().BackgroundColor.withOpacity(0.9),
            CustomColors().CardColor.withOpacity(0.95)
          ], begin: Alignment.topLeft, end: Alignment.centerRight),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Icon(
            Icons.person,
            size: 100,
            color: CustomColors().LightText,
          ),
          const SizedBox(height: 20,),
          profilePageCard(),
          const SizedBox(height: 30,),
          profilePageCard(),
          const SizedBox(height: 30,),
          profilePageCard(),
        ]),
      ),
    );
  }

  Column profilePageCard() {
    return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                myTextWidget('first name', 18.sp, FontWeight.w400, CustomColors().LightText),
                const SizedBox(width: 50,),
                GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.edit, color: CustomColors().LightText,))
              ],
            ),
            Container(
              width: double.maxFinite,
              height: 60,
              decoration: BoxDecoration(
                  color: CustomColors().HighlightColor,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: myTextWidget('flora', 25.sp, FontWeight.w500, CustomColors().LightText)),
            )
          ],
        );
  }
}
