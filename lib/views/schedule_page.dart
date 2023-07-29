import 'package:dojonotes/configurations/customwidgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:dojonotes/views/completed_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {

    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: CustomColors().BackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 360.h,
        backgroundColor: CustomColors().BackgroundColor,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: CustomColors().HighlightColor,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30.r), bottomLeft: Radius.circular(30.r)),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: statusBarHeight,
                  left: 0.w,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_rounded, size: 30),
                    onPressed: () {
                      Get.back();
                    },
                  )),
              Positioned(
                  top: statusBarHeight+35.h,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      myTextWidget('Today, ', 30.sp, FontWeight.bold),
                      myTextWidget(
                          'The Date Today Is', 20.sp, FontWeight.normal),
                    ],
                  )),
              Positioned(
                  top: statusBarHeight+75.h,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 200.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        kataButton('Gojushiho Sho'),
                        kataButton('Wankan'),
                        kataButton('Enpi'),
                      ],
                    ),
                  )),
              Positioned(
                  bottom: 18.h,
                  right: 80.w,
                  child: SizedBox(
                    width: 150.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        roundButtons(60.sp, Icons.add, ()=>Null),
                        roundButtons(60.sp, Icons.edit, ()=>Null)
                      ],
                    ),
                  )),
              Positioned(
                  bottom: 3.h,
                  right: 170.w,
                  child: myTextWidget('Add Note', 13.sp, FontWeight.bold)),
              Positioned(
                  bottom: 3.h,
                  right: 82.w,
                  child: myTextWidget('Edit Note', 13.sp, FontWeight.bold))
            ],
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        color: CustomColors().BackgroundColor,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Get.to(()=>const CompletedSchedulePage());
                },
                title: const Text('Thursday, 16th June, 2023'),
                leading: const Icon(Icons.library_add_check_outlined),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Heian Yondan, Jion, jiin'),
                    Text('Note: Felt Smooth')
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            );
          },




        ),
      ),
    );
  }
}
