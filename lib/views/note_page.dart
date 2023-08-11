import 'package:cloud_firestore/cloud_firestore.dart';
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
  String documentID = Get.arguments[0];
  String category = Get.arguments[1];
  String technique = Get.arguments[2];
  String personalNote = Get.arguments[3];
  String senseiNote = Get.arguments[4];

  TextEditingController _editController = TextEditingController();

  //Content state
  bool isCategorySaved = false;
  bool isTechniqueSaved = false;
  bool isPersonalNoteSaved = false;
  bool isSenseiNoteSaved = false;

  //Content values
  String savedNoteValue = '';
  String savedCategoryValue = '';
  String savedTechniqueValue = '';
  String savedPersonalNoteValue = '';
  String savedSenseiNoteValue = '';

  void editNote(category, content, docID, savedTitle) {
    if (savedTitle == 'category' && savedCategoryValue != '') {
      _editController = TextEditingController(text: savedCategoryValue);
    } else if (savedTitle == 'technique' && savedTechniqueValue != '') {
      _editController = TextEditingController(text: savedTechniqueValue);
    } else if (savedTitle == 'personalNote' && savedPersonalNoteValue != '') {
      _editController = TextEditingController(text: savedPersonalNoteValue);
    } else if (savedTitle == 'senseiNote' && savedSenseiNoteValue != '') {
      _editController = TextEditingController(text: savedSenseiNoteValue);
    } else {
      _editController = TextEditingController(text: content);
    }

    Get.dialog(AlertDialog(
      backgroundColor: CustomColors().BackgroundColor,
      title: myTextWidget(
          category, 15.sp, FontWeight.w400, CustomColors().LightText),
      content: myEditField(_editController),
      actions: [
        TextButton(
            onPressed: () => Get.back(),
            child: myTextWidget(
                'cancel', 15.sp, FontWeight.w400, CustomColors().LightText)),
        ElevatedButton(
            onPressed: () async {
              if (_editController.text.trim() != content) {
                try {
                  final docUser = FirebaseFirestore.instance
                      .collection('dojo notes')
                      .doc(docID);

                  await docUser.update({category: _editController.text.trim()});

                  setState(() {
                    savedNoteValue = _editController.text.trim();

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

                  // _editController = TextEditingController(text: savedNoteValue);

                  Get.back();
                  buildSnackBar('SUCCESS', 'Note Edited Successfully', 1);
                } catch (e) {
                  buildSnackBar('ERROR', e);
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
    _editController.dispose();
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
                            'The Date Today Is', 20.0, FontWeight.w600),
                      ],
                    )),
                Positioned(
                    top: statusBarHeight + 10.h,
                    left: 5,
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
                  // children: [
                  //
                  // ],
                  children: [
                    notePageContainer('Category', category, 'category',
                        isCategorySaved, 'category'),
                    notePageContainer('Technique/ Name', technique, 'technique',
                        isTechniqueSaved, 'technique'),
                    notePageContainer('Personal Note', personalNote,
                        'personal note', isPersonalNoteSaved, 'personalNote'),
                    notePageContainer('Sensei\'s Note', senseiNote,
                        'sensei note', isSenseiNoteSaved, 'senseiNote'),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container notePageContainer(
      title, content, firebaseTitle, bool isSaved, savedTitle) {
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
                  children: [
                    myTextWidget(title, 12.sp, FontWeight.w300,
                        CustomColors().LightText),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () => editNote(
                        firebaseTitle, content, documentID, savedTitle),
                    child: Icon(
                      Icons.edit,
                      color: CustomColors().ButtonColor,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
