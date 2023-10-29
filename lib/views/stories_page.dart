import 'package:animate_do/animate_do.dart';
import 'package:dojonotes/configurations/custom_widgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:dojonotes/views/onboardingpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class StoriesPage extends StatelessWidget {
  const StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    List storyList = [
      'Ever experienced that frustrating moment when you recall a technique in your daily routine, eager to perfect it, only to forget it when you step into the dojo?',
      'Well, worry no more! Introducing DojoNotes, the ultimate app that ensures you never miss a beat.',
      'Capture and keep track of those techniques that need perfecting, empowering you to progress like never before!'
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        itemCount: 3,

        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            height: double.maxFinite,
            width: double.maxFinite,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/welcome1.jpg'),
                    fit: BoxFit.cover)),
            child: Stack(
              children: [
                Positioned(
                    top: statusBarHeight + 8.h,
                    left: 7.w,
                    child: SizedBox(
                        width: 170,
                        height: 270,
                        child: myTextWidget(
                            storyList[index],
                            20.sp,
                            FontWeight.w400,
                            Colors.white))),
                Positioned(
                  bottom: 10.h,
                  right: 0,
                  left: 0,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (indexDots){
                          return Container(
                            margin: const EdgeInsets.only(right: 2),
                            height: 8,
                            width: index==indexDots?25:8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: index==indexDots?Colors.white:Colors.grey.shade300.withOpacity(0.7)
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 20.h,),
                      Flash(
                        animate: index == 2? true : false,
                        infinite: true,
                        duration: const Duration(milliseconds: 4500),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => const OnboardingScreen());
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50.w),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: CustomColors().buttonColor,
                                borderRadius: BorderRadius.circular(10.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xff65432a).withOpacity(0.5),
                                    blurRadius: 50,
                                    spreadRadius: 20
                                  )
                                ]
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  myTextWidget('GET STARTED', 20.sp, FontWeight.w600),
                                  Flexible(child: Image.asset('assets/images/arrow.png'))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
