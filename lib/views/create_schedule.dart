import 'package:dojonotes/configurations/custom_widgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:dojonotes/controllers/open_ai_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/kata_schedule_controller.dart';

class CreateSchedulePage extends StatefulWidget {
  const CreateSchedulePage({super.key});

  @override
  State<CreateSchedulePage> createState() => _CreateSchedulePageState();
}

class _CreateSchedulePageState extends State<CreateSchedulePage> {
  int selectedIndex = -1;
  List<Map<String, dynamic>> daysOfTheWeek = [
    {'day': 'Mon', 'isSelected': false},
    {'day': 'Tue', 'isSelected': false},
    {'day': 'Wen', 'isSelected': false},
    {'day': 'Thurs', 'isSelected': false},
    {'day': 'Fri', 'isSelected': false},
    {'day': 'Sat', 'isSelected': false},
    {'day': 'Sun', 'isSelected': false},
    // Add more items as needed
  ];
  List<String> selectedDays = [];

  OpenAIService openAIService = OpenAIService();

  void uploadSchedule() {}

  @override
  Widget build(BuildContext context) {
    final scheduleController = Get.put(KataScheduleController());

    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: myTextWidget('Select Katas', 25.0, FontWeight.w900,
            CustomColors().darkTitleText),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        flexibleSpace: const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(right: 15, left: 15),
            child: Divider(
              color: Colors.black,
              thickness: 1.5,
            ),
          ),
        ),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    myTextWidget('How many Katas would you practice in a day?',
                        15.sp, FontWeight.w400, CustomColors().linkText),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          5,
                          (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      index == selectedIndex
                                          ? Icons.circle
                                          : Icons.circle_outlined,
                                      color: index == selectedIndex
                                          ? CustomColors().darkContentText
                                          : CustomColors().whiteContentText,
                                    ),
                                    myTextWidget(
                                        '${index + 1}',
                                        16.sp,
                                        FontWeight.w400,
                                        CustomColors().darkInfoText)
                                  ],
                                ),
                              )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                myTextWidget('On which days of the week do you practice Kata?',
                    15.sp, FontWeight.w400, CustomColors().linkText),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                      daysOfTheWeek.length,
                      (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                daysOfTheWeek[index]['isSelected'] =
                                    !daysOfTheWeek[index]['isSelected'];
                                if (daysOfTheWeek[index]['isSelected']) {
                                  selectedDays.add(daysOfTheWeek[index]['day']);
                                } else {
                                  selectedDays
                                      .remove(daysOfTheWeek[index]['day']);
                                }
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  daysOfTheWeek[index]['isSelected']
                                      ? Icons.check_box_outlined
                                      : Icons.check_box_outline_blank_outlined,
                                  color: daysOfTheWeek[index]['isSelected']
                                      ? CustomColors().darkContentText
                                      : CustomColors().whiteContentText,
                                ),
                                myTextWidget(
                                    daysOfTheWeek[index]['day'],
                                    16.sp,
                                    FontWeight.w400,
                                    CustomColors().darkInfoText)
                              ],
                            ),
                          )),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: scheduleController.kataList.length,
                itemBuilder: (context, index) {
                  return GetX<KataScheduleController>(
                    builder: (_) {
                      return GestureDetector(
                        onTap: () {
                          scheduleController.toggleSelection(index);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: scheduleController
                                      .kataList[index].isSelected.value
                                  ? CustomColors().highlightColor
                                  : CustomColors().cardColor,
                              border: Border.all(width: 0.4)),
                          child: Center(
                              child: myTextWidget(
                                  scheduleController.kataList[index].name,
                                  20.0,
                                  FontWeight.normal,
                                  scheduleController
                                          .kataList[index].isSelected.value
                                      ? CustomColors().darkContentText
                                      : CustomColors().whiteContentText)),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (selectedIndex > 0 ||
                    selectedDays.isNotEmpty ||
                    scheduleController.selectedKatas.isNotEmpty) {
                  await openAIService.generateSchedule(
                      days: selectedDays,
                      numberOfKatas: selectedIndex + 1,
                      kataList: scheduleController.selectedKatas);
                } else {
                  print('ERRORRRRRRRRRRRR');
                }
              },
              child: Container(
                height: 60,
                width: double.maxFinite,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                decoration: BoxDecoration(
                    color: CustomColors().buttonColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: myTextWidget('Create Schedule', 20.sp, FontWeight.w800,
                      CustomColors().whiteTitleText),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
