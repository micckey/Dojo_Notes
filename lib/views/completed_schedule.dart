import 'package:dojonotes/configurations/customwidgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:flutter/material.dart';

class CompletedSchedulePage extends StatelessWidget {
  const CompletedSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().HighlightColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title:
            myTextWidget('View Schedule', 20.0, FontWeight.w500, Colors.white),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15))),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            myTextWidget('The Date Today Is', 20.0, FontWeight.w500),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 370,
              height: 650,
              child: ListView(
                children: [
                  Container(
                    color: CustomColors().CardColor,
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: myTextWidget(
                            'Heian Yondan', 20.0, FontWeight.normal),
                      ),
                    ),
                  ),
                  Container(
                    color: CustomColors().CardColor,
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: myTextWidget('Jion', 20.0, FontWeight.normal),
                      ),
                    ),
                  ),
                  Container(
                    color: CustomColors().CardColor,
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: myTextWidget('Jiin', 20.0, FontWeight.normal),
                      ),
                    ),
                  ),
                  Container(
                    color: CustomColors().CardColor,
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: myTextWidget(
                            'Lorem Ipsum', 20.0, FontWeight.normal),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
