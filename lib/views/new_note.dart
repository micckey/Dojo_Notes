import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojonotes/auth_pages/auth_provider.dart';
import 'package:dojonotes/configurations/customwidgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:dojonotes/views/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewNote extends StatefulWidget {
  const NewNote({super.key});

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  // text controllers
  final _categoryController = TextEditingController();
  final _techniqueController = TextEditingController();
  final _personalNoteController = TextEditingController();
  final _senseiNoteController = TextEditingController();

  //user id
  final userID = Get.arguments[0];

  @override
  void dispose() {
    super.dispose();
    _categoryController.dispose();
    _techniqueController.dispose();
    _personalNoteController.dispose();
    _senseiNoteController.dispose();
  }

  void addNewNote() {
    if (_categoryController.text == '' ||
        _techniqueController.text == '' ||
        _personalNoteController.text == '') {
      buildSnackBar('ERROR!!', 'Fill in all fields first then try again.', CustomColors().alertText);
    } else {
      if (userID == Null) {
        buildSnackBar('Error Adding Note',
            'An unexpected error occurred while saving the note, please try again later', CustomColors().alertText);
      } else {
        createNote(
            userID,
            _categoryController.text.trim(),
            _techniqueController.text.trim(),
            _personalNoteController.text.trim(),
            _senseiNoteController.text.trim());

        buildSnackBar('SUCCESS', 'Note added successfully', CustomColors().successText);
        Get.to(() => const AuthProvider());
      }
    }
  }

  Future createNote(String userId, String category, String technique,
      String personalNote, String senseiNote) async {
    await FirebaseFirestore.instance.collection('dojo notes').add({
      'userId': userId,
      'category': category,
      'technique': technique,
      'personal note': personalNote,
      'sensei note': senseiNote,
      'createdAt': FieldValue.serverTimestamp(),
      'updateAt': FieldValue.serverTimestamp()
    });
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final fullScreenHeight = MediaQuery.of(context).size.height;
    final fullScreenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 85.h,
        elevation: 0.0,
        backgroundColor: CustomColors().backgroundColor,
        flexibleSpace: ClipPath(
          clipper: CustomClipPath(),
          child: Container(
            width: double.infinity,
            height: 140.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25.r),
                    bottomLeft: Radius.circular(25.r)),
                color: CustomColors().highlightColor),
            child: Stack(
              children: <Widget>[
                Center(
                  child: Text('Add Note',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold)),
                ),
                Positioned(
                    top: statusBarHeight + 5.h,
                    right: 20.w,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications_active,
                          size: 50.sp, color: Colors.white),
                    )),
              ],
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 650.h,
                margin: EdgeInsets.only(right: 14.w, left: 14.w, top: 20.h),
                // color: Colors.grey,
                child: Column(
                  children: <Widget>[
                    myTextField(_categoryController, 'category',
                        CustomColors().cardColor),
                    SizedBox(
                      height: 30.h,
                    ),
                    myTextField(_techniqueController, 'technique/name',
                        CustomColors().cardColor),
                    SizedBox(
                      height: 30.h,
                    ),
                    myTextField(_personalNoteController, 'personal note',
                        CustomColors().cardColor, 8),
                    SizedBox(
                      height: 30.h,
                    ),
                    myTextField(_senseiNoteController, 'note from sensei',
                        CustomColors().cardColor, 4),
                    SizedBox(
                      height: 50.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: myTextWidget('cancel', 20.sp, FontWeight.w400,
                              CustomColors().titleText),
                        ),
                        SizedBox(
                          width: 90,
                          height: 50,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      CustomColors().buttonColor),
                                  shape: const MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              bottomRight:
                                                  Radius.circular(8))))),
                              onPressed: () => addNewNote(),
                              child:
                                  myTextWidget('save', 20.sp, FontWeight.w400)),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();

    path.lineTo(0, h);
    path.quadraticBezierTo(
      w * 0.5,
      h - 70.h,
      w,
      h,
    );
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
