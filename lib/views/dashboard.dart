import 'package:dojonotes/configurations/style.dart';
import 'package:dojonotes/views/kata_list.dart';
import 'package:dojonotes/views/new_note.dart';
import 'package:dojonotes/views/schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors().HighlightColor,
        elevation: 0,
        toolbarHeight: 240.h,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.r),
                bottomRight: Radius.circular(15.r))),
        flexibleSpace: Stack(
          children: <Widget>[
            Positioned(
                top: statusBarHeight + 5.h,
                left: 10.w,
                child: Text('Hi,',
                    style: TextStyle(
                        fontSize: 30.sp, fontWeight: FontWeight.w600))),
            Positioned(
                top: statusBarHeight + 40.h,
                left: 10.w,
                child: Text('Mike',
                    style: TextStyle(
                        fontSize: 60.sp, fontWeight: FontWeight.w700))),
            Positioned(
              right: 0,
              top: statusBarHeight + 10.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // border: Border.all(color: CustomColors().ButtonColor, width: 5),
                      color: CustomColors().ButtonColor,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu_rounded),
                      color: Colors.black,
                      iconSize: 60.sp,
                      padding: const EdgeInsets.all(1),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(() => const NewNote());
                    },
                    icon: const Icon(Icons.add_circle_rounded),
                    color: CustomColors().ButtonColor,
                    iconSize: 110.sp,
                    // padding: EdgeInsets.all(1),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 30.h,
              left: 15.w,
              child: SizedBox(
                height: 50.h,
                width: 240.w,
                // color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 45.h,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.to(SchedulePage());
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  CustomColors().ButtonColor),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.r)))),
                          child: Text(
                            'Schedule',
                            style: TextStyle(fontSize: 20.sp),
                          )),
                    ),
                    SizedBox(
                      height: 45.h,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.to(KataListPage());
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  CustomColors().ButtonColor),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.r)))),
                          child: Text(
                            'Kata list',
                            style: TextStyle(fontSize: 20.sp),
                          )),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Saved Notes',
            style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(bottom: 10.h),
              height: double.maxFinite,
              margin: EdgeInsets.only(left: 14.w, right: 14.w),
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 150,
                      width: 360,
                      margin: EdgeInsets.only(bottom: 10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: CustomColors().CardColor,
                      ),
                    );
                  },




              ),
            ),
          )
        ],
      ),
    );
  }
}
