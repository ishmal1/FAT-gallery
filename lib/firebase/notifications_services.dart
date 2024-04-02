// import 'dart:math';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:login_signup/utils/image_constant.dart';
//
// class NotificationServices{
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNitificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   void requestNotificationPermissions() async {
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       sound: true,
//       announcement: true,
//       carPlay: true,
//       badge: true,
//       provisional: true,
//       criticalAlert: true,
//     );
//
//     if(settings.authorizationStatus == AuthorizationStatus.authorized)
//       {
//         print("User granted permission");
//       }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
//       print("User granted provisional permission");
//
//
//     }else{
//       print("User denied permission");
//
//     }
//
// }
//
//
//   Future<String> getDeviceToken() async{
//     String? token = await messaging.getToken();
//     return token!;
//   }
//
//
//   void isTokenRefreshed() async{
//     messaging.onTokenRefresh.listen((event) {
//       event.toString();
//       print("refresh");
//     });
//   }
//
//   void initLocalNotifications(BuildContext context, RemoteMessage message) async{
//     var androidInitializationSettings = AndroidInitializationSettings(ImageConstant.watch);
//     var iosInitializationSettings = IOSInitializationSettings();
//
//     var initializationSetting = InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iosInitializationSettings,
//     );
//     await _flutterLocalNitificationsPlugin.initialize(initializationSetting,
//       // onSelectNotification: ,
//     );
//   }
//
//   Future<void> showNotifications(RemoteMessage message) async{
//
//
//     AndroidNotificationDetails channel = AndroidNotificationDetails(
//         Random.secure().nextInt(10000).toString(),
//         "Important Messgae",
//         "The Fine Arts",
//       importance: Importance.max
//     );
//
//     AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
//         channel.channelId.toString(),
//         channel.channelName.toString(),
//         channel.channelDescription.toString(),
//       importance: Importance.high,
//       ticker: "ticker",
//       priority: Priority.high
//     );
//
//     IOSNotificationDetails iosNotificationDetails =IOSNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );
//
//     NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//       iOS: iosNotificationDetails,
//     );
//
//     Future.delayed(Duration.zero, (){
//       _flutterLocalNitificationsPlugin.show(
//           0,
//           message.notification!.title.toString(),
//           message.notification!.body.toString(),
//           notificationDetails);
//     });
//
//   }
//
//   void firebaseInit(){
//     FirebaseMessaging.onMessage.listen((message) {
//       if(kDebugMode){
//
//       print(message.notification!.title.toString());
//       print(message.notification!.body.toString());}
//       showNotifications(message);
//
//     });
//   }
//
//   void handleMessage(BuildContext context, RemoteMessage message){
//
//   }
// }