import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyApple extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppleState();
  }
}

class _MyAppleState extends State<MyApple> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  List<String> _notifications = [];

  @override
  void initState() {
    super.initState();
    configureFirebaseMessaging();
  }

  void configureFirebaseMessaging() async {
    await _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        final title = message.notification!.title ?? '';
        final body = message.notification!.body ?? '';

        setState(() {
          _notifications.add('$title: $body');
        });

        // Custom implementation of showing the order notification
        _showOrderNotification(title, body);
      }
    });
  }

  void _showOrderNotification(String title, String body) {
    setState(() {
      _notifications.add('$title: $body');
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            ElevatedButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _handleConfirmOrder() {
    // Logic to handle the ConfirmOrder button press
    // Send a push notification when the order is confirmed

    final title = 'Order Confirmed';
    final body = 'Your order has been confirmed.';

    _showOrderNotification(title, body);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('FCM Notification Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Push the app to the background and send a notification to see it in action.'),
              ElevatedButton(
                onPressed: _handleConfirmOrder,
                child: Text('Confirm Order'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationScreen(notifications: _notifications)),
            );
          },
          child: Icon(Icons.notifications),
        ),
      ),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  final List<String> notifications;

  const NotificationScreen({required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            title: Text(notification),
          );
        },
      ),
    );
  }
}