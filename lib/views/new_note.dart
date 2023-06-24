import 'package:dojonotes/configurations/customwidgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:flutter/material.dart';

class NewNote extends StatefulWidget {
  const NewNote({super.key});

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 85,
        elevation: 0.0,
        backgroundColor: Colors.white,
        flexibleSpace: ClipPath(
          clipper: CustomClipPath(),
          child: Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
                color: CustomColors().HighlightColor
            ),
            child: Stack(
              children: <Widget> [
                const Center(
                  child: Text('Add Note',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      )),
                ),
                Positioned(
                    top: 50,
                    right: 20,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_active, size: 50, color: Colors.white),
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
          child: Column(
            children: [

              Container(
                width: double.infinity,
                height: 600,
                margin: const EdgeInsets.only(left: 14, right: 14),
                // color: Colors.grey,
                child: Column(
                  children: <Widget> [
                    myTextField('category', CustomColors().CardColor),
                    const SizedBox(height: 25,),
                    myTextField('technique', CustomColors().CardColor),
                    const SizedBox(height: 25,),
                    myTextField('personal note', CustomColors().CardColor, 8),
                    const SizedBox(height: 25,),
                    myTextField('note from sensei', CustomColors().CardColor, 4),
                    const SizedBox(height: 25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: myTextWidget('cancel', 20.0, FontWeight.w400),),
                        SizedBox(
                          width: 90,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(CustomColors().ButtonColor),
                              shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomRight: Radius.circular(8))))
                            ),
                              onPressed: () {},
                              child: myTextWidget('save', 20.0, FontWeight.w400)),
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
      h - 70,
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

