import 'package:dojonotes/configurations/customwidgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {

  List noteTitles = [
    '',
    'Category: ',
    'Technique/ Name: ',
    'Personal Note: ',
    'Sensei\'s Note: '
  ];
  List noteDetails = Get.arguments;

  
  @override
  Widget build(BuildContext context) {

    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: CustomColors().HighlightColor,
      body: Column(
        children: [
          SizedBox(
            height: 130,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                    top: 100,
                    left: 100,
                    child: myTextWidget(
                        'The Date Today Is', 20.0, FontWeight.w400)),
                Positioned(
                    top: statusBarHeight+10.h,
                    left: 5,
                    child: roundButtons(60.0, Icons.arrow_back_rounded, ()=>Get.back()))
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                color: CustomColors().BackgroundColor,
              ),
              child: Column( children: List.generate(noteDetails.length, (index){
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  width: double.maxFinite,
                  color: CustomColors().CardColor,
                  child: index==0?Container():
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            myTextWidget(noteTitles[index], 15.sp, FontWeight.w300, CustomColors().LightText),
                            Flexible(child: myTextWidget(noteDetails[index], 20.sp, FontWeight.w500, CustomColors().LightText)),
                          ],
                        ),
                        index>2?Row(

                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: ()=>Null,
                                child: Icon(Icons.edit, color: CustomColors().ButtonColor,))
                          ],
                        ):Container(),
                      ],
                    ),
                  ),
                );
              }),

              ),
            ),
          )
        ],
      ),
    );
  }
}
