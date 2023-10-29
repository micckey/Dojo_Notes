import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojonotes/configurations/custom_widgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:dojonotes/models/kata_list_model.dart';
import 'package:dojonotes/views/kata_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class KataListPage extends StatefulWidget {
  const KataListPage({super.key});

  @override
  State<KataListPage> createState() => _KataListPageState();
}

class _KataListPageState extends State<KataListPage>
    with TickerProviderStateMixin {
  //Kata List Model
  Future<KataListModel?> getKataData(kataID) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('kata_list')
        .doc(kataID)
        .get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()!;

      return KataListModel(
        kataName: data['name'],
        kataCategory: data['category'],
        kataDescription: data['description'],
        kataMeaning: data['meaning'],
        kataLink: data['link'],
        kataSteps: data['steps'],
      );
    } else {
      return null;
    }
  }

  //Search controller
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  late Map<String, Future<List<String>>> categoryFutures;

  @override
  void initState() {
    super.initState();

    // Initialize the categoryFutures map in the initState method
    categoryFutures = {
      'All': getDocID('All'),
      'Novice': getDocID('Novice'),
      'Senior': getDocID('Senior'),
      'Advanced': getDocID('Advanced'),
    };
  }

  Future<List<String>> getDocID(String category) async {
    List<String> docIDs = [];

    QuerySnapshot snapshot;

    if (category == 'All') {
      // Fetch all documents in the 'kata_list' collection
      snapshot = await FirebaseFirestore.instance.collection('kata_list').get();
    } else {
      // Fetch documents in the 'kata_list' collection with the specified category
      snapshot = await FirebaseFirestore.instance
          .collection('kata_list')
          .where('category', isEqualTo: category)
          .get();
    }

    // Extract the document IDs from the fetched snapshot
    docIDs = snapshot.docs.map((doc) => doc.id).toList();

    return docIDs;
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabcontroller = TabController(length: 4, vsync: this);

    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;

    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title:
            myTextWidget('Shotokan Katas', 25.0, FontWeight.w900, CustomColors().contentText),
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
              width: double.maxFinite,
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: CustomColors().highlightColor,
                borderRadius: BorderRadius.circular(10.r)
              ),

              child: TextField(
                controller: _searchController,
                onChanged: (text) {
                  setState(() {
                    _searchText = text;
                  });
                },
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0)),
                    hintText: 'search kata',
                    prefixIcon:
                        const Icon(Icons.search, color: Colors.black54),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: CustomColors().highlightColor),
                        borderRadius: BorderRadius.circular(0))),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TabBar(
                  controller: _tabcontroller,
                  // isScrollable: true,
                  indicator: RectangularIndicator(
                      paintingStyle: PaintingStyle.fill,
                      bottomLeftRadius: 15.r,
                      bottomRightRadius: 15.r,
                      topLeftRadius: 15.r,
                      topRightRadius: 15.r),
                  tabs: const [
                    Tab(
                      text: 'All',
                    ),
                    Tab(
                      text: 'Novice',
                    ),
                    Tab(
                      text: 'Senior',
                    ),
                    Tab(
                      text: 'Advanced',
                    ),
                  ]),
            ),
            Container(
              width: double.maxFinite,
              height: bodyHeight * 0.8.h,
              margin: const EdgeInsets.symmetric(vertical: 20),
              // color: Colors.white,
              child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  controller: _tabcontroller,
                  children: [
                    FutureBuilder<List<String>>(
                      future: categoryFutures['All'],
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return buildKataList(snapshot.data);
                        } else {
                          return  Center(
                              child: LoadingAnimationWidget.discreteCircle(color: CustomColors().highlightColor, size: 50.r));
                        }
                      },
                    ),
                    FutureBuilder<List<String>>(
                      future: categoryFutures['Novice'],
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return buildKataList(snapshot.data);
                        } else {
                          return Center(
                              child: LoadingAnimationWidget.discreteCircle(color: CustomColors().highlightColor, size: 50.r));
                        }
                      },
                    ),
                    FutureBuilder<List<String>>(
                      future: categoryFutures['Senior'],
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return buildKataList(snapshot.data);
                        } else {
                          return Center(
                              child: LoadingAnimationWidget.discreteCircle(color: CustomColors().highlightColor, size: 50.r));
                        }
                      },
                    ),
                    FutureBuilder<List<String>>(
                      future: categoryFutures['Advanced'],
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return buildKataList(snapshot.data);
                        } else {
                          return Center(
                              child: LoadingAnimationWidget.discreteCircle(color: CustomColors().highlightColor, size: 50.r));
                        }
                      },
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildKataList(List<String>? docIDs) {
    if (docIDs == null || docIDs.isEmpty) {
      return const Center(child: Text('No katas found.'));
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: docIDs.length,
      itemBuilder: (context, index) {
        String kataID = docIDs[index];

        return FutureBuilder<KataListModel?>(
          future: getKataData(kataID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data != null) {
                KataListModel data = snapshot.data!;

                String name = data.kataName;
                String category = data.kataCategory;
                String description = data.kataDescription;
                String meaning = data.kataMeaning;
                String link = data.kataLink;
                var steps = data.kataSteps;

                // Filter katas based on the search text
                if (_searchText.isEmpty ||
                    name.toLowerCase().contains(_searchText.toLowerCase())) {
                  // If the search text matches or is empty, return the kata item
                  return GestureDetector(
                    onTap: () {
                      Get.to(const KataPage(), arguments: [
                        name,
                        category,
                        description,
                        meaning,
                        link,
                        steps
                      ]);
                    },
                    child: Container(
                      height: 60,
                      width: double.maxFinite,
                      margin: const EdgeInsets.only(
                          bottom: 10, left: 20, right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: CustomColors().cardColor,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            myTextWidget(name, 20.0, FontWeight.w400, CustomColors().contentText),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  // If the search text doesn't match, return an empty container
                  return const SizedBox.shrink();
                }
              } else {
                return const SizedBox.shrink();
              }
            } else {
              return Container(
                  height: 60,
                  width: double.maxFinite,
                  margin:
                      const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: CustomColors().cardColor,
                  ),
                  child: Center(
                      child:
                          myTextWidget('loading...', 16.0, FontWeight.w300, CustomColors().contentText)));
            }
          },
        );
      },
    );
  }
}
