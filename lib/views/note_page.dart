import 'package:dojonotes/configurations/customwidgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
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
                    top: 60,
                    child: SizedBox(
                      width: 395,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          roundButtons(60.0, Icons.arrow_back_rounded),
                          const SizedBox(
                            width: 150,
                          ),
                          roundButtons(60.0, Icons.edit),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 696,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              color: Colors.white,
            ),
            child: Container(
              color: Colors.grey,
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: ListView(
                padding: const EdgeInsets.only(top: 0),
                scrollDirection: Axis.vertical,
                children: [
                  myTextWidget('category', 15.0, FontWeight.normal),
                  Container(
                    height: 60,
                    color: CustomColors().CardColor,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
