import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dojonotes/auth_pages/auth_provider.dart';
import 'package:dojonotes/configurations/notification_service.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:dojonotes/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  AwesomeNotifications().initialize('resource://drawable/res_ic_launcher', [
    NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Schedule Notification',
        channelDescription: 'Trigger the scheduled notifications',
        importance: NotificationImportance.High,
        vibrationPattern: mediumVibrationPattern,
        defaultPrivacy: NotificationPrivacy.Public,
        defaultRingtoneType: DefaultRingtoneType.Alarm,
        playSound: true,
        enableVibration: true,
        channelShowBadge: true,
        defaultColor: CustomColors().highlightColor.withOpacity(0.5)),
  ]);

  AwesomeNotifications()
      .setListeners(onActionReceivedMethod: handleNotificationActionReceived);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'RobotoSlab'),
      home: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final screenSize = constraints.biggest;
          return ScreenUtilInit(
            builder: (context, child) => const SplashScreen(),
            designSize: screenSize,
          );
        },
      ),
    );
  }
}
