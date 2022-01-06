import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:school_alarm/enums.dart';
import 'package:school_alarm/models/menu_info.dart';
import 'package:school_alarm/notification_service.dart';
import 'package:school_alarm/views/myhome_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService notificationService = NotificationService();
  await notificationService.init();
  await notificationService.requestIOSPermissions();
  // var initializationSettingsAndroid =
  //     AndroidInitializationSettings('pintarmedia_logo');
  // var initialoonSettingIOS = IOSInitializationSettings(
  //   requestAlertPermission: true,
  //   requestBadgePermission: true,
  //   requestSoundPermission: true,
  //   onDidReceiveLocalNotification: (id, title, body, payload) {},
  // );
  // var initializationSettings = InitializationSettings(
  //   android: initializationSettingsAndroid,
  //   iOS: initialoonSettingIOS,
  // );
  // await flutterLocalNotificationsPlugin.initialize(
  //   initializationSettings,
  //   onSelectNotification: (payload) async {
  //     if (payload != null) {
  //       debugPrint('notifikasi payload : ' + payload);
  //     }
  //   },
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alarm Sekolah',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: ChangeNotifierProvider<MenuInfo>(
          create: (context) => MenuInfo(MenuType.clock),
          child: MyHomePage(title: 'Alarm Sekolah')),
    );
  }
}
