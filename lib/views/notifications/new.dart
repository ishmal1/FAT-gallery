import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:login_signup/utils/image_constant.dart';
import 'package:login_signup/views/notifications/notifications_page.dart';

class MyAppNoti extends StatefulWidget {
  @override
  _MyAppNotiState createState() => _MyAppNotiState();
}

class _MyAppNotiState extends State<MyAppNoti> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    requestNotificationPermissions();
    var initializationSettingsAndroid =
    AndroidInitializationSettings('watch');
    var iosNotificatonDetail = DarwinInitializationSettings();
    var initSetttings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: iosNotificatonDetail,
    );

    flutterLocalNotificationsPlugin.initialize(
      initSetttings,
      onDidReceiveNotificationResponse: (val){
        Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => notifications_screen())
        );},
    );
  }
  void requestNotificationPermissions() async {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNitificationsPlugin = FlutterLocalNotificationsPlugin();

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      sound: true,
      announcement: true,
      carPlay: true,
      badge: true,
      provisional: true,
      criticalAlert: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized)
    {
      print("User granted permission");
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print("User granted provisional permission");


    }else{
      print("User denied permission");

    }

  }


  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  Future<void> showNotification() async {
    var android = AndroidNotificationDetails(
      'id',
      'channel',
      priority: Priority.high,
      importance: Importance.max,
    );
    var iosNotificatonDetail = DarwinNotificationDetails();
    var platform = NotificationDetails(
      android: android,
      iOS: iosNotificatonDetail,
    );

    // Set the payload with the route of the target page
    var payload = 'notification_page';
    await flutterLocalNotificationsPlugin.show(
      0,
      'Flutter devs',
      'Flutter Local Notification Demo',
      platform,
      payload: payload,
    );
  }

  Future<void> handleNotificationPayload(
      int id, String? title, String? body, String? payload) async {
    if (payload == 'notification_page') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => notifications_screen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Flutter notification demo'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: showNotification,
              child: Text('showNotification'),
            ),
            ElevatedButton(
              onPressed: cancelNotification,
              child: Text('cancelNotification'),
            ),
          ],
        ),
      ),
    );
  }
}

class NewScreen extends StatelessWidget {
  final String? payload;

  NewScreen({
    required this.payload,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(payload!),
      ),
      body: Center(
        child: Text('Welcome to the Notification Page!'),
      ),
    );
  }
}
