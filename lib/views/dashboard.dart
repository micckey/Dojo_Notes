import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojonotes/configurations/customwidgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:dojonotes/views/dashboard_drawer.dart';
import 'package:dojonotes/views/kata_list.dart';
import 'package:dojonotes/views/new_note.dart';
import 'package:dojonotes/views/note_page.dart';
import 'package:dojonotes/views/schedule_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //Get username
  Future<Map<String, dynamic>> getUserDetails(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return userSnapshot.data()!;
  }

  //Delete note
  void deleteNote(docID) async {
    try {
      final docUser =
          FirebaseFirestore.instance.collection('dojo notes').doc(docID);
      await docUser.delete();
      buildSnackBar(
          'SUCCESS', 'Note Deleted Successfully', CustomColors().SuccessText);
    } catch (e) {
      buildSnackBar('ERROR', 'An unexpected Error occurred.\nPlease try again',
          CustomColors().AlertText);
    }
  }


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: CustomColors().BackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors().HighlightColor,
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
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.5.sp,
                          color: CustomColors().LightText,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.menu_rounded,
                      size: 40,
                      color: CustomColors().ButtonColor,
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
                      // myTextWidget('Mike', 60.sp, FontWeight.w700),
                      FutureBuilder<Map<String, dynamic>>(
                        future: getUserDetails(user.uid),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // Display a loading indicator while fetching data.
                            return myTextWidget('...', 60.sp, FontWeight.w700);
                          } else if (snapshot.hasData) {
                            // Data is available, access first name here.
                            String firstName = snapshot.data!['first name'];
                            return Padding(
                              padding: const EdgeInsets.all(0),
                              child: myTextWidget(
                                  firstName, 60.sp, FontWeight.w700),
                            );
                          } else {
                            // Data not found or an error occurred.
                            return myTextWidget(
                                'Karateka', 60.sp, FontWeight.w700);
                          }
                        },
                      ),
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
                      delay: const Duration(seconds: 4),

                      child: IconButton(
                        onPressed: () {
                          Get.to(() => const NewNote(), arguments: [user.uid]);
                        },
                        icon: const Icon(Icons.add_circle_rounded),
                        color: CustomColors().ButtonColor,
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
                  width: 240.w,
                  // color: Colors.grey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 45.h,
                        child: buildElevatedButton('Schedule', () {
                          Get.to(() => SchedulePage());
                        }),
                      ),
                      SizedBox(
                          height: 45.h,
                          child: buildElevatedButton('Kata List', () {
                            Get.to(() => const KataListPage());
                          }))
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          myTextWidget(
              'Saved Notes', 30.sp, FontWeight.w900, CustomColors().LightText),
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
                    .where('userId', isEqualTo: user.uid)
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while fetching data.
                    return Center(
                        child: LoadingAnimationWidget.discreteCircle(
                            color: CustomColors().HighlightColor, size: 50.r));
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
                        String category = notes[index]['category'];
                        String technique = notes[index]['technique'];
                        String personalNote = notes[index]['personal note'];
                        String senseiNote = notes[index]['sensei note'];

                        return GestureDetector(
                          onTap: () {
                            String documentId = notes[index].id;
                            Timestamp? editTimeStamp = notes[index]['updateAt'];
                            Get.to(() => const NotePage(), arguments: [
                              documentId,
                              category,
                              technique,
                              personalNote,
                              senseiNote,
                              editTimeStamp
                            ]);
                          },
                          child: FadeInRight(
                            duration: const Duration(milliseconds: 1500),
                            delay: index == 0 ? const Duration(seconds: 0): const Duration(milliseconds: 1500),
                            child: Container(
                              width: 360,
                              margin: EdgeInsets.only(bottom: 10.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: CustomColors().CardColor,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    dashboardNoteCard('Category: ', category),
                                    dashboardNoteCard(
                                        'Technique/ Name: ', technique),
                                    dashboardNoteCard(
                                      'Personal Note: ',
                                      personalNote,
                                    ),
                                    senseiNote != ''
                                        ? dashboardNoteCard(
                                            'Sensei\'s Note: ',
                                            senseiNote,
                                          )
                                        : const SizedBox.shrink(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
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
                                                      color: CustomColors()
                                                          .HighlightColor),
                                                  cancel: dialogButton(
                                                    buttonFunction: () {
                                                      Get.back();
                                                    },
                                                    label: 'No',
                                                    color: CustomColors()
                                                        .HighlightColor,
                                                  ));
                                            },
                                            child: Icon(Icons.delete,
                                                color: CustomColors().AlertText,
                                                size: 30.sp)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    // Data not found or an error occurred.
                    return Center(
                        child: myTextWidget('Add Notes to View', 15.sp,
                            FontWeight.w400, CustomColors().LightText));
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
