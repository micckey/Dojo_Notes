import 'package:dojonotes/configurations/customwidgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:flutter/material.dart';

class CreateSchedulePage extends StatefulWidget {
  const CreateSchedulePage({super.key});

  @override
  State<CreateSchedulePage> createState() => _CreateSchedulePageState();
}

class _CreateSchedulePageState extends State<CreateSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().BackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title:
            myTextWidget('Select Katas', 25.0, FontWeight.w900, Colors.white),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              color: CustomColors().BackgroundColor,
              padding: const EdgeInsets.only(right: 15),
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                width: 250,
                height: 50,
                color: CustomColors().HighlightColor,
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0)),
                      hintText: 'search kata',
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.black54),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: CustomColors().HighlightColor),
                          borderRadius: BorderRadius.circular(0))),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                kataCategoryButton('Novice'),
                kataCategoryButton('Senior'),
                kataCategoryButton('Advanced'),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              // color: Colors.white,
              height: 560,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: CustomColors().CardColor,
                        border: Border.all(width: 0.4)),
                    child: Center(
                        child: myTextWidget(
                            'Heian Shodan', 20.0, FontWeight.normal)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: CustomColors().CardColor,
                        border: Border.all(width: 0.4)),
                    child: Center(
                        child: myTextWidget(
                            'Heian Shodan', 20.0, FontWeight.normal)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: CustomColors().CardColor,
                        border: Border.all(width: 0.4)),
                    child: Center(
                        child: myTextWidget(
                            'Heian Shodan', 20.0, FontWeight.normal)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: CustomColors().CardColor,
                        border: Border.all(width: 0.4)),
                    child: Center(
                        child: myTextWidget(
                            'Heian Shodan', 20.0, FontWeight.normal)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: CustomColors().CardColor,
                        border: Border.all(width: 0.4)),
                    child: Center(
                        child: myTextWidget(
                            'Heian Shodan', 20.0, FontWeight.normal)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: CustomColors().CardColor,
                        border: Border.all(width: 0.4)),
                    child: Center(
                        child: myTextWidget(
                            'Heian Shodan', 20.0, FontWeight.normal)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: CustomColors().CardColor,
                        border: Border.all(width: 0.4)),
                    child: Center(
                        child: myTextWidget(
                            'Heian Shodan', 20.0, FontWeight.normal)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: CustomColors().CardColor,
                        border: Border.all(width: 0.4)),
                    child: Center(
                        child: myTextWidget(
                            'Heian Shodan', 20.0, FontWeight.normal)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: CustomColors().CardColor,
                        border: Border.all(width: 0.4)),
                    child: Center(
                        child: myTextWidget(
                            'Heian Shodan', 20.0, FontWeight.normal)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: CustomColors().CardColor,
                        border: Border.all(width: 0.4)),
                    child: Center(
                        child: myTextWidget(
                            'Heian Shodan', 20.0, FontWeight.normal)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
