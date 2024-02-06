import 'package:dojonotes/configurations/custom_widgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CompletedSchedulePage extends StatelessWidget {
  const CompletedSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {

    final fullScreenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: CustomColors().highlightColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title:
        myTextWidget('View Schedule', 20.sp, FontWeight.w500, CustomColors().whiteTitleText),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: CustomColors().backgroundColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r))),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            myTextWidget('The Date Today Is', 20.0, FontWeight.w500, CustomColors().whiteTitleText),
            SizedBox(
              height: 40.h,
            ),
            Expanded(
              child: SizedBox(
                width: 370.w,
                height: double.maxFinite,
                child: ListView(
                  children: [
                    Container(
                      color: CustomColors().cardColor,
                      margin: const EdgeInsets.only(bottom: 30),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: myTextWidget(
                              'Heian Yondan', 20.0, FontWeight.normal),
                        ),
                      ),
                    ),
                    Container(
                      color: CustomColors().cardColor,
                      margin: const EdgeInsets.only(bottom: 30),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: myTextWidget('Jion', 20.0, FontWeight.normal),
                        ),
                      ),
                    ),
                    Container(
                      color: CustomColors().cardColor,
                      margin: const EdgeInsets.only(bottom: 30),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: myTextWidget('Jiin', 20.0, FontWeight.normal),
                        ),
                      ),
                    ),
                    Container(
                      height: 250.h,
                      color: CustomColors().cardColor,
                      margin: const EdgeInsets.only(bottom: 30),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: myTextWidget(
                            'Lorem Ipsum', 20.0, FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
