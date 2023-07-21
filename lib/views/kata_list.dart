import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojonotes/configurations/customwidgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:dojonotes/models/kata_list.dart';
import 'package:dojonotes/views/kata_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class KataListPage extends StatefulWidget {
  const KataListPage({super.key});

  @override
  State<KataListPage> createState() => _KataListPageState();
}

class _KataListPageState extends State<KataListPage>
    with TickerProviderStateMixin {
  // //document IDs
  // List<String> docIDs = [];
  //
  // //get docIDs
  // Future getDocID(String category) async {
  //   await FirebaseFirestore.instance.collection('kata_list').where('category', isEqualTo: category).get().then(
  //           (snapshot) => snapshot.docs.forEach((element) {
  //             docIDs.add(element.reference.id);
  //           }));
  // }

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
  Widget build(BuildContext context) {
    TabController _tabcontroller = TabController(length: 4, vsync: this);

    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;

    return Scaffold(
      backgroundColor: CustomColors().BackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title:
            myTextWidget('Shotokan Katas', 25.0, FontWeight.w900, Colors.white),
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                    FutureBuilder<List<String>>(
                      future: categoryFutures['Novice'],
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return buildKataList(snapshot.data);
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                    FutureBuilder<List<String>>(
                      future: categoryFutures['Senior'],
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return buildKataList(snapshot.data);
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                    FutureBuilder<List<String>>(
                      future: categoryFutures['Advanced'],
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return buildKataList(snapshot.data);
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
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
      itemCount: docIDs.length,
      itemBuilder: (context, index) {
        return Container(
          height: 60,
          width: double.maxFinite,
          margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.purpleAccent,
          ),
          child: Center(
            child: KataListModel(kataID: docIDs[index]),
          ),
        );
      },
    );
  }
}
