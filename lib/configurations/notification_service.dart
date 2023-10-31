import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojonotes/configurations/custom_widgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:dojonotes/models/notification_model.dart';
import 'package:dojonotes/views/note_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

//Set big picture image
String setBigPicturePath(category) {
  if (category.toString().toLowerCase() == 'kihon') {
    return 'asset://assets/images/kihon.jpg';
  } else if (category.toString().toLowerCase() == 'kata') {
    return 'asset://assets/images/kata.png';
  } else {
    return 'asset://assets/images/kumite.jpeg';
  }
}

void handleNotificationActionReceived () {
  AwesomeNotifications().actionStream.listen((notification) {
    String? documentID = notification.payload?['documentID'];

    final docUser =
    FirebaseFirestore.instance.collection('dojo notes').doc(documentID);
    docUser.update({'isScheduled': false});

    FirebaseFirestore.instance
        .collection('dojo notes')
        .doc(documentID) // Use .doc() to specify the document by ID
        .get()
        .then((docSnapshot) {
      if (docSnapshot.exists) {
        // The document with the specified ID exists
        Map<String, dynamic> documentData =
            docSnapshot.data() as Map<String, dynamic>;

        // Pass the data to the NotePage
        String category = documentData['category'];
        String technique = documentData['technique'];
        String personalNote = documentData['personal note'];
        String senseiNote = documentData['sensei note'];
        bool isScheduled = documentData['isScheduled'];

        Get.to(() => const NotePage(),
            arguments: [
              documentID,
              category,
              technique,
              personalNote,
              senseiNote,
              isScheduled
            ],
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 1500));



      } else {
        buildSnackBar(
            'Error', 'An unexpected error occurred', CustomColors().alertText);
      }
    }).catchError((error) {
      buildSnackBar(
          'Error',
          'There might be an error with your internet connection, please ty again later',
          CustomColors().alertText);
    });
  });
}

Future<String> createTrainingNotification(
  category,
  Schedule notificationSchedule,
  String documentID,
) async {
  final currentTime = DateTime.now();
  final selectedTime = notificationSchedule.time;

  if (selectedTime.isBefore(currentTime)) {
    // The selected time is before the current time
    buildSnackBar(
        'Failed. Choose a different time',
        'Cannot set a reminder before the current time!!!',
        CustomColors().alertText);
    return 'error'; // Exit the function to prevent scheduling the notification
  }

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'scheduled_channel',
        title:
            '\u{1F94B} ${Emojis.sport_boxing_glove} Get up and start grinding!! ${Emojis.sport_boxing_glove} \u{1F94B}',
        body:
            'OSS! Don\'t forget to perfect your \n ${notificationSchedule.details} \u{1F44D} \u{1F4AA}',
        notificationLayout: NotificationLayout.BigPicture,
        wakeUpScreen: true,
        payload: {'documentID': documentID},
        category: NotificationCategory.Reminder,
        bigPicture: setBigPicturePath(category),
        summary: 'The time has come',
        locked: true),
    actionButtons: [
      NotificationActionButton(
        key: 'view_notification',
        label: 'VIEW',
      ),
    ],
    schedule: NotificationCalendar(
      weekday: notificationSchedule.time.weekday,
      hour: notificationSchedule.time.hour,
      minute: notificationSchedule.time.minute,
      second: 0,
      millisecond: 0,
    ),
  );

  final docUser =
      FirebaseFirestore.instance.collection('dojo notes').doc(documentID);
  docUser.update({'isScheduled': true});

  buildSnackBar(
      'Success', 'Reminder created successfully', CustomColors().successText);

  return 'success';
}

Future<void> cancelScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}

void allowNotifications() {
  Get.dialog(AlertDialog(
    title: myTextWidget(
        'Allow Notifications', 24.sp, FontWeight.w600, CustomColors().infoText),
    content: myTextWidget('Our app would like to send you notifications', 20.sp,
        FontWeight.w400, CustomColors().contentText),
    backgroundColor: CustomColors().cardColor,
    actions: [
      TextButton(
        onPressed: () {
          AwesomeNotifications().requestPermissionToSendNotifications();
          Get.back();
        },
        child: myTextWidget(
            'ALLOW', 16.sp, FontWeight.w300, CustomColors().successText),
      ),
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: myTextWidget(
              'DON\'T ALLOW', 16.sp, FontWeight.w300, CustomColors().alertText))
    ],
  ));
}
