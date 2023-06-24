import 'package:dojonotes/configurations/style.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
                color: CustomColors().HighlightColor,
                borderRadius: BorderRadius.circular(15)),
            child: Stack(
              children: <Widget>[
                const Positioned(
                    top: 60,
                    left: 10,
                    child: Text('Hi,',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600))),
                const Positioned(
                    top: 90,
                    left: 10,
                    child: Text('Mike',
                        style: TextStyle(
                            fontSize: 60, fontWeight: FontWeight.w700))),
                Positioned(
                    right: 35,
                    top: 60,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        // border: Border.all(color: CustomColors().ButtonColor, width: 5),
                        color: CustomColors().ButtonColor,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu_rounded),
                        color: Colors.black,
                        iconSize: 60,
                        padding: const EdgeInsets.all(1),
                      ),
                    )),
                Positioned(
                    right: 0,
                    top: 130,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle_rounded),
                      color: CustomColors().ButtonColor,
                      iconSize: 110,
                      // padding: EdgeInsets.all(1),
                    )),
                Positioned(
                  bottom: 35,
                  left: 15,
                  child: SizedBox(
                    height: 50,
                    width: 240,
                    // color: Colors.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 45,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      CustomColors().ButtonColor),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)))),
                              child: const Text(
                                'Schedule',
                                style: TextStyle(fontSize: 20),
                              )),
                        ),
                        SizedBox(
                          height: 45,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      CustomColors().ButtonColor),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)))),
                              child: const Text(
                                'Kata list',
                                style: TextStyle(fontSize: 20),
                              )),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Saved Notes',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 450,
            margin: const EdgeInsets.only(left: 14, right: 14),
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(0),
              children: [
                Container(
                  height: 150,
                  width: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: CustomColors().CardColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 150,
                  width: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: CustomColors().CardColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 150,
                  width: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: CustomColors().CardColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 150,
                  width: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: CustomColors().CardColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 150,
                  width: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: CustomColors().CardColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 150,
                  width: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: CustomColors().CardColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
