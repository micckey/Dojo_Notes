import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojonotes/configurations/customwidgets.dart';
import 'package:flutter/material.dart';

// class KataListModel extends StatelessWidget {
//   const KataListModel({super.key, required this.kataID});
//
//   final String kataID;
//
//   @override
//   Widget build(BuildContext context) {
//
//     CollectionReference kataList = FirebaseFirestore.instance.collection('kata_list');
//
//     return FutureBuilder<DocumentSnapshot>(
//       future: kataList.doc(kataID).get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done){
//             Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
//             return myTextWidget('${data['name']}', 20.0, FontWeight.w400);
//           }
//           return Text('loading...');
//         },);
//   }
// }

class KataListModel {
  final String kataID;

  KataListModel({required this.kataID});

  Future<Map<String, dynamic>?> getKataData() async {
    CollectionReference kataList = FirebaseFirestore.instance.collection('kata_list');
    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await kataList.doc(kataID).get() as DocumentSnapshot<Map<String, dynamic>>;

    if (snapshot.exists) {
      return snapshot.data();
    } else {
      return null;
    }
  }
}





