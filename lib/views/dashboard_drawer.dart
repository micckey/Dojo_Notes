import 'package:dojonotes/configurations/custom_widgets.dart';
import 'package:dojonotes/configurations/notification_service.dart';
import 'package:dojonotes/views/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth_pages/login_page.dart';
import '../configurations/style.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.email});

  final String? firstName;
  final String? lastName;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: CustomColors().backgroundColor,
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
                      Get.to(() => const ProfilePage(),
                          arguments: [firstName, lastName, email]);
                      Scaffold.of(context).closeDrawer();
                    }),
                SizedBox(
                  height: 50.h,
                ),
                drawerListTile(
                    icon: Icons.notifications_off_outlined,
                    title: 'Cancel all notifications',
                    onTapFunction: () {
                      Get.defaultDialog(
                        title: 'Cancel Notifications',
                        titleStyle: TextStyle(color: CustomColors().linkText),
                        middleText:
                            'Are you sure you want to cancel all scheduled notifications?',
                        confirm: dialogButton(
                            buttonFunction: () {
                              cancelScheduledNotifications();
                              Scaffold.of(context).closeDrawer();
                            },
                            label: 'Yes',
                            color: CustomColors().highlightColor),
                        cancel: dialogButton(
                            buttonFunction: () {
                              Get.back();
                            },
                            color: CustomColors().highlightColor,
                            label: 'No'),
                      );
                    }),
              ],
            ),
            drawerListTile(
                icon: Icons.logout_rounded,
                title: 'Logout',
                onTapFunction: () {
                  Get.defaultDialog(
                      title: 'Logout',
                      titleStyle: TextStyle(color: CustomColors().linkText),
                      middleText: 'Are you sure you want to log out?',
                      confirm: dialogButton(
                          buttonFunction: () async {
                            FirebaseAuth.instance.signOut();
                            final SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.remove('token');
                            Get.to(() => const LoginScreen());
                          },
                          label: 'Yes',
                          color: CustomColors().highlightColor),
                      cancel: dialogButton(
                          buttonFunction: () {
                            Get.back();
                          },
                          color: CustomColors().highlightColor,
                          label: 'No'));
                }),
          ],
        ),
      ),
    );
  }

  ListTile drawerListTile({required IconData icon, title, onTapFunction}) {
    return ListTile(
      leading: Icon(icon, color: CustomColors().darkInfoText, size: 40.sp),
      title: myTextWidget(
          title, 20.sp, FontWeight.w500, CustomColors().darkTitleText),
      onTap: onTapFunction,
    );
  }
}
