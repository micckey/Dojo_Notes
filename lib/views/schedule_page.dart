import 'package:dojonotes/configurations/customwidgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 360,
        backgroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: CustomColors().HighlightColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: 40,
                  left: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_rounded, size: 30),
                    onPressed: () {},
                  )),
              Positioned(
                  top: 78,
                  left: 15,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      myTextWidget('Today, ', 30.0, FontWeight.bold),
                      myTextWidget(
                          'The Date Today Is', 20.0, FontWeight.normal),
                    ],
                  )),
              Positioned(
                  top: 120,
                  left: 20,
                  child: SizedBox(
                    height: 200,
                    // color: Colors.pinkAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        kataButton('Gojushiho Sho'),
                        kataButton('Wankan'),
                        kataButton('Enpi'),
                      ],
                    ),
                  )),
              Positioned(
                  bottom: 20,
                  right: 80,
                  child: SizedBox(
                    width: 150,
                    // color: Colors.pinkAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        roundButtons(60.0, Icons.add),
                        roundButtons(60.0, Icons.edit)
                      ],
                    ),
                  )),
              Positioned(
                  bottom: 5,
                  right: 170,
                  child: myTextWidget('Add Note', 13.0, FontWeight.bold)),
              Positioned(
                  bottom: 5,
                  right: 82,
                  child: myTextWidget('Edit Note', 13.0, FontWeight.bold))
            ],
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        color: CustomColors().BackgroundColor,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Card(
              child: ListTile(
                title: const Text('Thursday, 16th June, 2023'),
                leading: const Icon(Icons.album),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Heian Yondan, Jion, jiin'),
                    Text('Note: Felt Smooth')
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Thursday, 16th June, 2023'),
                leading: const Icon(Icons.album),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Heian Yondan, Jion, jiin'),
                    Text('Note: Felt Smooth')
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Thursday, 16th June, 2023'),
                leading: const Icon(Icons.album),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Heian Yondan, Jion, jiin'),
                    Text('Note: Felt Smooth')
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Thursday, 16th June, 2023'),
                leading: const Icon(Icons.album),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Heian Yondan, Jion, jiin'),
                    Text('Note: Felt Smooth')
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Thursday, 16th June, 2023'),
                leading: const Icon(Icons.album),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Heian Yondan, Jion, jiin'),
                    Text('Note: Felt Smooth')
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Thursday, 16th June, 2023'),
                leading: const Icon(Icons.album),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Heian Yondan, Jion, jiin'),
                    Text('Note: Felt Smooth')
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Thursday, 16th June, 2023'),
                leading: const Icon(Icons.album),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Heian Yondan, Jion, jiin'),
                    Text('Note: Felt Smooth')
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Thursday, 16th June, 2023'),
                leading: const Icon(Icons.album),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Heian Yondan, Jion, jiin'),
                    Text('Note: Felt Smooth')
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
