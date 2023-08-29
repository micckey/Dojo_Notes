import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojonotes/configurations/customwidgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  String documentID = Get.arguments[0];
  String category = Get.arguments[1];
  String technique = Get.arguments[2];
  String personalNote = Get.arguments[3];
  String senseiNote = Get.arguments[4];
  Timestamp? timestamp = Get.arguments[5];

  String formatTimestamp(Timestamp? timestamp) {
    // Convert Firestore Timestamp to DateTime
    if (timestamp != null) {
      DateTime dateTime = timestamp.toDate();

      if (DateTime.now().difference(dateTime) < const Duration(days: 1)) {
        if (DateTime.now().difference(dateTime) < const Duration(seconds: 60)) {
          return 'Just Now';
        } else if (DateTime.now().difference(dateTime) <
            const Duration(hours: 1)) {
          if (DateTime.now().difference(dateTime) <
              const Duration(minutes: 2)) {
            return '1 minute ago';
          }
          return ' ${dateTime.difference(DateTime.now()).inMinutes.toString().substring(1)} minutes ago';
        } else if (DateTime.now().difference(dateTime) <
            const Duration(hours: 2)) {
          return '1 hour ago';
        }
        return ' ${dateTime.difference(DateTime.now()).inHours.toString().substring(1)} hours ago';
      } else {
        // Format DateTime using intl package's DateFormat
        return DateFormat('MMM d, y - HH:mm a').format(dateTime);
      }
    }
    return '...';
  }

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
      backgroundColor: CustomColors().BackgroundColor,
      title: myTextWidget(
          category, 15.sp, FontWeight.w400, CustomColors().LightText),
      content: myEditField(editController),
      actions: [
        TextButton(
            onPressed: () => Get.back(),
            child: myTextWidget(
                'cancel', 15.sp, FontWeight.w400, CustomColors().LightText)),
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
                  buildSnackBar('SUCCESS', 'Note Edited Successfully', CustomColors().SuccessText, 1);
                } catch (e) {
                  buildSnackBar('ERROR', e, CustomColors().AlertText);
                }
              } else {
                Get.back();
              }
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(CustomColors().ButtonColor)),
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
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        myTextWidget('Last edited: ', 18.0, FontWeight.w400),
                        myTextWidget(
                            isCategorySaved ||
                                    isTechniqueSaved ||
                                    isPersonalNoteSaved ||
                                    isSenseiNoteSaved
                                ? 'Just Now'
                                : formatTimestamp(timestamp),
                            20.0,
                            FontWeight.w600),
                      ],
                    )),
                Positioned(
                    top: statusBarHeight + 10.h,
                    left: 10.w,
                    child: roundButtons(
                        60.0, Icons.arrow_back_rounded, () => Get.back()))
              ],
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
                color: CustomColors().BackgroundColor,
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
      color: CustomColors().CardColor,
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
                        CustomColors().LightText),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () => editNote(firebaseTitle, content, documentID,
                                savedTitle, editController, savedNoteValue),
                            child: content == ''
                                ? Icon(Icons.add_circle_rounded,
                                size: 50.sp, color: CustomColors().SuccessText)
                                : Icon(
                              Icons.edit,
                              color: CustomColors().SuccessText,
                            ))
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                        child: myTextWidget(isSaved ? savedNoteValue : content,
                            20.sp, FontWeight.w500, CustomColors().LightText)),
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
