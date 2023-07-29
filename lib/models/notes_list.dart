import 'package:cloud_firestore/cloud_firestore.dart';

class NotesListModel {
  final String userID;

  NotesListModel({required this.userID});

  Future<Map<String, dynamic>?> getNoteData() async {
    CollectionReference kataList = FirebaseFirestore.instance.collection('dojo notes');
    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await kataList.doc(userID).get() as DocumentSnapshot<Map<String, dynamic>>;

    if (snapshot.exists) {
      return snapshot.data();
    } else {
      return null;
    }
  }
}