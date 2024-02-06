import 'package:animate_do/animate_do.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojonotes/configurations/custom_widgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:dojonotes/configurations/time_formatter.dart';
import 'package:dojonotes/views/dashboard_drawer.dart';
import 'package:dojonotes/views/kata_list.dart';
import 'package:dojonotes/views/new_note.dart';
import 'package:dojonotes/views/note_page.dart';
import 'package:dojonotes/views/schedule_page_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.userID});

  final String userID;
  final String? firstName;
  final String? lastName;
  final String? email;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //Delete note
  void deleteNote(docID) async {
    try {
      final docUser =
          FirebaseFirestore.instance.collection('dojo notes').doc(docID);
      await docUser.delete();
      buildSnackBar(
          'SUCCESS', 'Note Deleted Successfully', CustomColors().successText);
    } catch (e) {
      buildSnackBar('ERROR', 'An unexpected Error occurred.\nPlease try again',
          CustomColors().alertText);
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: CustomColors().highlightColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors().backgroundColor,
        elevation: 0,
        toolbarHeight: 240.h,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.r),
                bottomRight: Radius.circular(15.r))),
        flexibleSpace: Builder(builder: (context) {
          return Stack(
            children: <Widget>[
              Positioned(
                top: statusBarHeight + 10.h,
                left: 10.w,
                child: GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer(); // Open the custom drawer
                  },
                  child: Spin(
                    delay: const Duration(seconds: 4),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.5.sp,
                            color: CustomColors().buttonColor,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.menu_rounded,
                        size: 40,
                        color: CustomColors().buttonColor,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: statusBarHeight + 55.h,
                  left: 10.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      myTextWidget('Hi,', 30.sp, FontWeight.w600),
                      myTextWidget(widget.firstName, 60.sp, FontWeight.w700),
                    ],
                  )),
              Positioned(
                right: 0,
                top: statusBarHeight + 10.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pulse(
                      duration: const Duration(seconds: 2),
                      delay: const Duration(seconds: 2),
                      child: IconButton(
                        onPressed: () {
                          Get.to(() => const NewNote(),
                              arguments: [widget.userID],
                              transition: Transition.circularReveal,
                              duration: const Duration(milliseconds: 1500));
                        },
                        icon: const Icon(Icons.add_circle_rounded),
                        color: CustomColors().buttonColor,
                        iconSize: 110.sp,
                        // padding: EdgeInsets.all(1),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 16.h,
                left: 15.w,
                child: SizedBox(
                  height: 50.h,
                  // width: 240.w,
                  // color: Colors.grey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 45.h,
                        child: Dance(
                          delay: const Duration(milliseconds: 3500),
                          child: dashboardElevatedButton('Schedule', () {
                            // Get.to(() => SchedulePage(), transition: Transition.upToDown, duration: const Duration(milliseconds: 1500));
                            Get.to(() =>
                                SchedulePageSwitcher(userID: widget.userID));
                          }),
                        ),
                      ),
                      const SizedBox(width: 5,),
                      SizedBox(
                          height: 45.h,
                          child: Dance(
                            delay: const Duration(milliseconds: 3500),
                            child: dashboardElevatedButton('Kata List', () {
                              Get.to(() => const KataListPage(),
                                  transition: Transition.upToDown,
                                  duration: const Duration(milliseconds: 1500));
                            }),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      drawer: MyDrawer(
        firstName: widget.firstName,
        lastName: widget.lastName,
        email: widget.email,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          myTextWidget('Saved Notes', 30.sp, FontWeight.w900,
              CustomColors().darkContentText),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(bottom: 10.h),
              height: double.maxFinite,
              margin: EdgeInsets.only(left: 14.w, right: 14.w),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('dojo notes')
                    .where('userId', isEqualTo: widget.userID)
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while fetching data.
                    return Center(
                        child: LoadingAnimationWidget.discreteCircle(
                            color: CustomColors().darkTitleText, size: 50.r));
                  } else if (snapshot.hasData && snapshot.data != null) {
                    // Data is available, access details here.
                    List<QueryDocumentSnapshot<Map<String, dynamic>>> notes =
                        snapshot.data!.docs;

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: notes.length,
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        // Access the fields in each note document.
                        String documentId = notes[index].id;
                        String category = notes[index]['category'];
                        String technique = notes[index]['technique'];
                        String personalNote = notes[index]['personal note'];
                        String senseiNote = notes[index]['sensei note'];
                        bool isScheduled = notes[index]['isScheduled'];

                        Timestamp? editTimeStamp = notes[index]['updateAt'];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => const NotePage(),
                                arguments: [
                                  documentId,
                                  category,
                                  technique,
                                  personalNote,
                                  senseiNote,
                                  isScheduled
                                ],
                                transition: Transition.fadeIn,
                                duration: const Duration(milliseconds: 1500));
                          },
                          child: index % 2 == 0
                              ? FadeInRight(
                                  duration: const Duration(milliseconds: 1500),
                                  // delay: index == 0 ? const Duration(seconds: 0): const Duration(milliseconds: 1500),
                                  child: dashboardNoteCard(
                                      category,
                                      technique,
                                      personalNote,
                                      senseiNote,
                                      notes,
                                      index,
                                      formatTimestamp(editTimeStamp), isScheduled),
                                )
                              : FadeInLeft(
                                  duration: const Duration(milliseconds: 1500),
                                  child: dashboardNoteCard(
                                      category,
                                      technique,
                                      personalNote,
                                      senseiNote,
                                      notes,
                                      index,
                                      formatTimestamp(editTimeStamp), isScheduled)),
                        );
                      },
                    );
                  } else {
                    // Data not found or an error occurred.
                    return Center(
                        child: myTextWidget('Add Notes to View', 15.sp,
                            FontWeight.w400, CustomColors().whiteTitleText));
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Container dashboardNoteCard(
      String category,
      String technique,
      String personalNote,
      String senseiNote,
      List<QueryDocumentSnapshot<Map<String, dynamic>>> notes,
      int index,
      time,
      isScheduled
      ) {
    return Container(
      width: 360,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: CustomColors().cardColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            dashboardNoteCardContent('Category: ', category),
            dashboardNoteCardContent('Technique/ Name: ', technique),
            dashboardNoteCardContent(
              'Personal Note: ',
              personalNote,
            ),
            senseiNote != ''
                ? dashboardNoteCardContent(
                    'Sensei\'s Note: ',
                    senseiNote,
                  )
                : const SizedBox.shrink(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Container(
                  child: isScheduled ? Icon(Icons.notifications, color: CustomColors().successText, size: 30.sp,) : null,
                ),
                Expanded(child: Container()),
                myTextWidget(
                    time, 15.sp, FontWeight.w400, CustomColors().whiteInfoText),
                SizedBox(
                  width: 20.w,
                ),
                GestureDetector(
                    onTap: () {
                      String documentID = notes[index].id;
                      Get.defaultDialog(
                          title: 'Alert!!',
                          middleText:
                              'Are you sure you want to delete? \n This action is irreversible!!',
                          confirm: dialogButton(
                              buttonFunction: () {
                                deleteNote(documentID);
                                Get.back();
                              },
                              label: 'Yes',
                              color: CustomColors().highlightColor),
                          cancel: dialogButton(
                            buttonFunction: () {
                              Get.back();
                            },
                            label: 'No',
                            color: CustomColors().highlightColor,
                          ));
                    },
                    child: Icon(Icons.delete,
                        color: CustomColors().alertText, size: 30.sp)),
              ],
            ),
            SizedBox(
              height: 5.h,
            )
          ],
        ),
      ),
    );
  }
}
