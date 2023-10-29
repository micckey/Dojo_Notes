import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojonotes/configurations/custom_widgets.dart';
import 'package:dojonotes/configurations/notification_service.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:dojonotes/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as theme;

DateTime scheduleTime = DateTime.now();

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  //Get arguments from dashboard card
  String documentID = Get.arguments[0];
  String category = Get.arguments[1];
  String technique = Get.arguments[2];
  String personalNote = Get.arguments[3];
  String senseiNote = Get.arguments[4];

  //Edit Controllers
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _techniqueController = TextEditingController();
  final TextEditingController _personalNoteController = TextEditingController();
  final TextEditingController _senseiNoteController = TextEditingController();

  //Content state
  bool isCategorySaved = false;
  bool isTechniqueSaved = false;
  bool isPersonalNoteSaved = false;
  bool isSenseiNoteSaved = false;

  //Content values
  String savedCategoryValue = '';
  String savedTechniqueValue = '';
  String savedPersonalNoteValue = '';
  String savedSenseiNoteValue = '';

  void editNote(category, content, docID, savedTitle,
      TextEditingController editController, savedNoteValue) {
    if (savedTitle == 'category' && savedCategoryValue != '') {
      editController = TextEditingController(text: savedCategoryValue);
    } else if (savedTitle == 'technique' && savedTechniqueValue != '') {
      editController = TextEditingController(text: savedTechniqueValue);
    } else if (savedTitle == 'personalNote' && savedPersonalNoteValue != '') {
      editController = TextEditingController(text: savedPersonalNoteValue);
    } else if (savedTitle == 'senseiNote' && savedSenseiNoteValue != '') {
      editController = TextEditingController(text: savedSenseiNoteValue);
    } else {
      editController = TextEditingController(text: content);
    }

    Get.dialog(AlertDialog(
      backgroundColor: CustomColors().backgroundColor,
      title: myTextWidget(
          category, 15.sp, FontWeight.w400, CustomColors().titleText),
      content: myEditField(editController),
      actions: [
        TextButton(
            onPressed: () => Get.back(),
            child: myTextWidget(
                'cancel', 15.sp, FontWeight.w400, CustomColors().titleText)),
        ElevatedButton(
            onPressed: () async {
              if (editController.text.trim() != content) {
                try {
                  final docUser = FirebaseFirestore.instance
                      .collection('dojo notes')
                      .doc(docID);

                  await docUser.update({
                    category: editController.text.trim(),
                    'updateAt': FieldValue.serverTimestamp()
                  });

                  setState(() {
                    savedNoteValue = editController.text.trim();

                    if (savedTitle == 'category') {
                      isCategorySaved = true;
                      savedCategoryValue = savedNoteValue;
                    } else if (savedTitle == 'technique') {
                      isTechniqueSaved = true;
                      savedTechniqueValue = savedNoteValue;
                    } else if (savedTitle == 'personalNote') {
                      isPersonalNoteSaved = true;
                      savedPersonalNoteValue = savedNoteValue;
                    } else if (savedTitle == 'senseiNote') {
                      isSenseiNoteSaved = true;
                      savedSenseiNoteValue = savedNoteValue;
                    }
                  });

                  Get.back();
                  buildSnackBar('SUCCESS', 'Note Edited Successfully',
                      CustomColors().successText, 1);
                } catch (e) {
                  buildSnackBar('ERROR', e, CustomColors().alertText);
                }
              } else {
                Get.back();
              }
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(CustomColors().buttonColor)),
            child: myTextWidget('Save', 15.sp, FontWeight.w400))
      ],
      actionsAlignment: MainAxisAlignment.center,
    ));
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _techniqueController.dispose();
    _personalNoteController.dispose();
    _senseiNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: CustomColors().highlightColor,
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: roundButtons(
                            60.0, Icons.arrow_back_rounded, () => Get.back()),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15.w),
                        child: roundButtons(
                            60.0, Icons.notifications_active_outlined, () {
                          AwesomeNotifications()
                              .isNotificationAllowed()
                              .then((isAllowed) {
                            if (isAllowed) {
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  onChanged: (date) => scheduleTime = date,
                                  onConfirm: (date) {
                                    createTrainingNotification(category,
                                        Schedule(
                                            details:
                                                technique,
                                            time: scheduleTime),
                                        documentID);
                                  },
                                  minTime: DateTime.now(),
                                  currentTime: DateTime.now(),
                                  theme: theme.DatePickerTheme(
                                    backgroundColor: CustomColors()
                                        .highlightColor
                                        .withOpacity(0.8),
                                    containerHeight: 300,
                                    itemStyle: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    doneStyle: TextStyle(
                                        color: CustomColors().successText,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                    cancelStyle: TextStyle(
                                        color: CustomColors().alertText),
                                  ));
                            } else {
                              allowNotifications();
                            }
                          });
                        }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                color: CustomColors().backgroundColor,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    notePageContainer(
                        'Category',
                        category,
                        'category',
                        isCategorySaved,
                        'category',
                        _categoryController,
                        savedCategoryValue),
                    notePageContainer(
                        'Technique/ Name',
                        technique,
                        'technique',
                        isTechniqueSaved,
                        'technique',
                        _techniqueController,
                        savedTechniqueValue),
                    notePageContainer(
                        'Personal Note',
                        personalNote,
                        'personal note',
                        isPersonalNoteSaved,
                        'personalNote',
                        _personalNoteController,
                        savedPersonalNoteValue),
                    notePageContainer(
                        'Sensei\'s Note',
                        senseiNote,
                        'sensei note',
                        isSenseiNoteSaved,
                        'senseiNote',
                        _senseiNoteController,
                        savedSenseiNoteValue),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container notePageContainer(title, content, firebaseTitle, bool isSaved,
      savedTitle, editController, savedNoteValue) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      width: double.maxFinite,
      color: CustomColors().cardColor,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    myTextWidget(title, 12.sp, FontWeight.w300,
                        CustomColors().titleText),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () => editNote(
                                firebaseTitle,
                                content,
                                documentID,
                                savedTitle,
                                editController,
                                savedNoteValue),
                            child: content == ''
                                ? Icon(Icons.add_circle_rounded,
                                    size: 50.sp,
                                    color: CustomColors().successText)
                                : Icon(
                                    Icons.edit,
                                    color: CustomColors().successText,
                                  ))
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                        child: myTextWidget(
                            isSaved ? savedNoteValue : content,
                            20.sp,
                            FontWeight.w500,
                            CustomColors().contentText)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
