import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojonotes/views/create_schedule.dart';
import 'package:dojonotes/views/loading_screen.dart';
import 'package:dojonotes/views/schedule_page.dart';
import 'package:flutter/material.dart';

class SchedulePageSwitcher extends StatelessWidget {
  const SchedulePageSwitcher({super.key, required this.userID});

  final String userID;

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>?> getScheduleID() async {
      DocumentSnapshot<Map<String, dynamic>> scheduleSnapshot =
          await FirebaseFirestore.instance
              .collection('personal_schedule')
              .doc(userID)
              .get();

      if (scheduleSnapshot.exists) {
        Map<String, dynamic> personalSchedule = scheduleSnapshot.data()!;
        return personalSchedule;
      } else {
        return null;
      }
    }

    return FutureBuilder(
      future: getScheduleID(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data != null) {
            Map<String, dynamic> data = snapshot.data!;
            print(data);
            return SchedulePage();
          }
          return const CreateSchedulePage();
        }
        return const LoadingScreen();
      },
    );
  }
}
