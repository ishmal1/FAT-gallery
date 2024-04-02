import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/big_text.dart';
import '../../utils/color_constant.dart';

// class MyApple extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _MyAppleState();
//   }
// }
//
// class _MyAppleState extends State<MyApple> {
//   FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   List<String> _notifications = [];
//   bool _hasNewNotifications = false;
//   bool _allNotificationsViewed = false;
//
//   @override
//   void initState() {
//     super.initState();
//     configureFirebaseMessaging();
//     listenToNotificationChanges();
//   }
//
//   void configureFirebaseMessaging() async {
//     await _firebaseMessaging.requestPermission();
//     String? token = await _firebaseMessaging.getToken();
//     print("FCM Token: $token");
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (message.notification != null) {
//         final title = message.notification!.title ?? '';
//         final body = message.notification!.body ?? '';
//
//         setState(() {
//           _notifications.add('$title: $body');
//           _hasNewNotifications = true;
//         });
//
//         _showOrderNotification(title, body);
//         _storeNotification(title, body);
//       }
//     });
//   }
//
//   void listenToNotificationChanges() {
//     final user = FirebaseAuth.instance.currentUser;
//     final userId = user?.uid;
//
//     if (userId != null) {
//       _firestore
//           .collection('Notifications')
//           .doc(userId)
//           .collection('userNotifications')
//           .snapshots()
//           .listen((snapshot) {
//         setState(() {
//           _hasNewNotifications = snapshot.docs.isNotEmpty;
//           _allNotificationsViewed = snapshot.docs.every((doc) => doc['viewed'] == true);
//
//           if (_allNotificationsViewed) {
//             _hasNewNotifications = false;
//           }
//         });
//       });
//     }
//   }
//
//   void _showOrderNotification(String title, String body) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(body),
//           actions: [
//             ElevatedButton(
//               child: Text('Close'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _storeNotification(String title, String body) async {
//     final user = FirebaseAuth.instance.currentUser;
//     final userId = user?.uid;
//
//     if (userId != null) {
//       try {
//         await _firestore.collection('Notifications').doc(userId).collection('userNotifications').add({
//           'title': title,
//           'body': body,
//           'uid': userId,
//           'timestamp': FieldValue.serverTimestamp(),
//           'viewed': false,
//         });
//         print('Notification stored in Firestore.');
//       } catch (error) {
//         print('Failed to store notification in Firestore: $error');
//       }
//     }
//   }
//
//   void _handleConfirmOrder() {
//     final title = 'Order Confirmed';
//     final body = 'Your order has been confirmed.';
//
//     _showOrderNotification(title, body);
//     _storeNotification(title, body);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('FCM Notification Example'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Push the app to the background and send a notification to see it in action.'),
//               ElevatedButton(
//                 onPressed: _handleConfirmOrder,
//                 child: Text('Confirm Order'),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => NotificationScreen(notifications: _notifications)),
//             );
//           },
//           child: Icon(Icons.notifications),
//           backgroundColor: _hasNewNotifications ? Colors.red : (_allNotificationsViewed ? Colors.black : Colors.blue),
//         ),
//       ),
//     );
//   }
// }
class notifications_screen extends StatefulWidget {
  // final List<String> notifications;

  const notifications_screen({key,});

  @override
  State<notifications_screen> createState() => _notifications_screenState();
}

class _notifications_screenState extends State<notifications_screen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _deleteNotification(BuildContext context, String docId) async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;

    if (userId != null) {
      try {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Delete Notification'),
              content: Text('Are you sure you want to delete this notification?'),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Delete'),
                  onPressed: () async {
                    // await FirebaseFirestore.instance
                    //     .collection('Notifications')
                    //     .doc(userId)
                    //     .collection('userNotifications')
                    //     .doc(docId)
                    //     .delete();
                    print('Notification deleted.');
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } catch (error) {
        print('Failed to delete notification: $error');
      }
    }
  }

  Future<void> _markNotificationAsViewed(String docId) async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;

    if (userId != null) {
      try {
        await FirebaseFirestore.instance
            .collection('Notifications')
            .doc(userId)
            .collection('userNotifications')
            .doc(docId)
            .update({
          'viewed': true,
        });
        print('Notification marked as viewed.');
      } catch (error) {
        print('Failed to mark notification as viewed: $error');
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> notifications = [
      {
        'id': '1',
        'title': 'Notification 1',
        'body': 'This is the first notification.',
        'timestamp': Timestamp.now(),
        'viewed': false,
      },
      {
        'id': '2',
        'title': 'Notification 2',
        'body': 'This is the second notification.',
        'timestamp': Timestamp.now(),
        'viewed': false,
      },
      // Add more dummy notifications as needed...
    ];


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Notifications",
          style: TextStyle(
            color: ColorConstants.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorConstants.grey,
        iconTheme: IconThemeData(
          color: ColorConstants.black,
        ),
      ),
      backgroundColor: ColorConstants.grey,
      body: Padding(
        padding: EdgeInsets.only(left: 15.w,right: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(
              size: 11.sp,
              fontWeight: FontWeight.w600, text: "Today",),
            SizedBox(height: 10.h,),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];

                  final docId = notification['id'];
                  final title = notification['title'];
                  final body = notification['body'];
                  final timestamp = notification['timestamp'] as Timestamp;

                  final dateTime = timestamp.toDate();

                  if (!notification['viewed']) {
                    _markNotificationAsViewed(docId);
                  }

                  return Dismissible(
                    key: Key(docId),
                    onDismissed: (_) => _deleteNotification(context, docId),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(
                        Icons.delete,
                        size: 22.sp,
                        color: Colors.white,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          tileColor: Colors.white,
                          title: Text(title,style:  TextStyle(color: Colors.black,fontSize: 12.sp,fontWeight: FontWeight.w600),),
                          subtitle: Text(body,style:TextStyle(color: Colors.black54,fontSize: 7.sp),),
                          trailing: Text('${dateTime.toString()}',style: TextStyle(fontSize: 9.sp),),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}


