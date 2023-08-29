import 'package:dojonotes/configurations/customwidgets.dart';
import 'package:dojonotes/views/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../auth_pages/login_page.dart';
import '../configurations/style.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: CustomColors().BackgroundColor,
      child: Padding(
        padding: EdgeInsets.only(top: 90.h, bottom: 40.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                drawerListTile(
                    icon: CupertinoIcons.home,
                    title: 'H O M E',
                    onTapFunction: () => Get.back()),
                drawerListTile(
                    icon: CupertinoIcons.person_fill,
                    title: 'P R O F I L E',
                    onTapFunction: () {
                      Get.to(() => const ProfilePage());
                      Scaffold.of(context).closeDrawer();
                    }),
              ],
            ),
            drawerListTile(
                icon: Icons.logout_rounded,
                title: 'Logout',
                onTapFunction: () {
                  Get.defaultDialog(
                      // backgroundColor: CustomColors().CardColor,
                      title: 'Logout',
                      middleText: 'Are you sure you want to log out?',
                      confirm: dialogButton(
                          buttonFunction: () {
                            FirebaseAuth.instance.signOut();
                            Get.to(() => const LoginScreen());
                          },
                          label: 'Yes',
                          color: CustomColors().HighlightColor),
                      cancel: dialogButton(
                          buttonFunction: () {
                            Get.back();
                          },
                          color: CustomColors().HighlightColor,
                          label: 'No'));
                }),
          ],
        ),
      ),
    );
  }

  ListTile drawerListTile({required IconData icon, title, onTapFunction}) {
    return ListTile(
      leading: Icon(icon, color: CustomColors().LightText, size: 40.sp),
      title:
          myTextWidget(title, 20.sp, FontWeight.w500, CustomColors().LightText),
      onTap: onTapFunction,
    );
  }
}
