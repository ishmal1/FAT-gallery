import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:login_signup/views/notifications/notifications_page.dart';
import 'package:login_signup/widgets/custom_button.dart';

import '../../../../utils/color_constant.dart';
import '../../widgets/form_fields.dart';

class shipping_address extends StatefulWidget {
  const shipping_address({Key? key}) : super(key: key);

  @override
  State<shipping_address> createState() => _shipping_addressState();
}

class _shipping_addressState extends State<shipping_address> {

  final formKey = GlobalKey<FormState>();


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController namecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  String? formattedCardNumber;
  // cardcontroller.text = formattedCardNumber ?? '';

  TextEditingController cardcontroller = TextEditingController();
  TextEditingController cvvcontroller = TextEditingController();
  TextEditingController expiryontroller = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;


  @override
  void initState() {
    super.initState();
    cardcontroller.text = formattedCardNumber ?? '';
  }
// Validate card number format
  String? validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a card number';
    }
    String cardNumber = value.replaceAll(RegExp(r'\D'), ''); // Remove non-digit characters
    if (cardNumber.length != 16) {
      return 'Card number should be 16 digits';
    }
    return null; // Return null for no validation errors
  }

// Format card number with slashes
  void formatCardNumber() {
    String value = cardcontroller.text.replaceAll(RegExp(r'\D'), '');
    if (value.length > 4) {
      value = value.substring(0, 4) + ' ' + value.substring(4);
    }
    if (value.length > 9) {
      value = value.substring(0, 9) + ' ' + value.substring(9);
    }
    if (value.length > 14) {
      value = value.substring(0, 14) + ' ' + value.substring(14);
    }
    cardcontroller.text = value;
    cardcontroller.selection = TextSelection.fromPosition(
      TextPosition(offset: cardcontroller.text.length),
    );
  }

  // Validate CVV
  String? validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter CVV';
    }
    if (value.length != 3) {
      return 'CVV should be exactly 3 digits';
    }
    return null; // Return null for no validation errors
  }

  // Validate Pakistani phone number
  // Validate Pakistani phone number
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter phone number';
    }

    // Remove any non-digit characters from the phone number
    String formattedPhoneNumber = value.replaceAll(RegExp(r'[^0-9]'), '');

    // Check if the formatted phone number is valid
    if (!RegExp(r'^(\+92|0)?3\d{9}$').hasMatch(formattedPhoneNumber)) {
      return 'Please enter a valid Pakistani phone number';
    }

    return null; // Return null for no validation errors
  }


  // Validate expiry date of credit card
  String? validateExpiryDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter expiry date';
    }

    // Remove any non-digit characters from the expiry date
    String formattedExpiryDate = value.replaceAll(RegExp(r'[^0-9/]'), '');

    // Check if the formatted expiry date is valid
    if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$').hasMatch(formattedExpiryDate)) {
      return 'Please enter a valid expiry date (MM/YY)';
    }

    // Split the expiry date into month and year
    List<String> parts = formattedExpiryDate.split('/');
    int month = int.tryParse(parts[0]) ?? 0;
    int year = int.tryParse(parts[1]) ?? 0;

    // Check if the month is valid (between 1 and 12)
    if (month < 1 || month > 12) {
      return 'Please enter a valid month (01-12)';
    }

    // Check if the year is valid (between current year and next 20 years)
    int currentYear = DateTime.now().year % 100;
    int currentMonth = DateTime.now().month;
    int next20Years = currentYear + 20;
    if (year < currentYear || (year == currentYear && month < currentMonth)) {
      return 'Please enter a future expiry date';
    }
    if (year > next20Years) {
      return 'Please enter a valid expiry date (within the next 20 years)';
    }

    return null; // Return null for no validation errors
  }




  Future<void> _saveShippingAddress() async {
    try {

      print('Shipping address saved successfully!');

    } catch (error) {
      // Handle any errors that occur during the save process
      print('Error saving shipping address: $error');
    }
  }


  // @override
  // void dispose() {
  //   namecontroller.dispose();
  //   addresscontroller.dispose();
  //   phonecontroller.dispose();
  //   cardcontroller.dispose();
  //   cvvcontroller.dispose();
  //   expiryontroller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.grey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Shipping Information",
          style: TextStyle(
            fontSize: 18.sp,
            color: ColorConstants.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorConstants.grey,
        iconTheme: IconThemeData(
          color: ColorConstants.black,
        ),
      ),
      body: Center(
        child: Container(
          width: Get.width / 1.2,
          child: Card(
            surfaceTintColor: Colors.white,
            color: Colors.white,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            elevation: 10,
            child: Padding(
              padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 15.h,bottom: 5.h),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      form_fields(
                        onChanged: (value) {},
                        onclick: () {},
                        secure: false,
                        fieldtext: "",
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        icon: Icons.person_outline_rounded,
                        label: "Name",
                        controller: namecontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter name';
                          }
                          // Additional validation logic can be added here
                          return null;
                        },
                      ),
                      SizedBox(height: 17.h),
                      form_fields(
                        onChanged: (value) {},
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onclick: () {},
                        secure: false,
                        fieldtext: "",
                        icon: Icons.phone_outlined,
                        label: "Phone",
                        maxlength: 11,
                        controller: phonecontroller,
                        validator: (value) {
                          String? validationResult = validatePhoneNumber(value);
                          if (validationResult != null) {
                            return validationResult;
                          }
                          return null; // Return null for no validation errors
                        },
                      ),
                      SizedBox(height: 17.h),
                      form_fields(
                        onChanged: (value) {},
                        onclick: () {},
                        secure: false,
                        fieldtext: "",
                        icon: Icons.location_city_outlined,
                        label: "Address",
                        keyboardType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.next,
                        controller: addresscontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter address';
                          }
                          // Additional validation logic can be added here
                          return null;
                        },
                      ),
                      SizedBox(height: 17.h),
                      TextFormField(
                        style: TextStyle(fontSize: 10.sp),
                  controller: cardcontroller,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    labelStyle: TextStyle(
                      fontSize: 13.sp
                    )
                  ),
                  maxLength: 19, // Total length including slashes
                  validator: (value) => validateCardNumber(value),
                  onChanged: (value) {
                    formatCardNumber();
                  },
                  ),
                      SizedBox(height: 17.h),
                      form_fields(
                        onChanged: (value) {},
                        onclick: () {},
                        secure: false,
                        maxlength: 3, // Total length including slashes
                        fieldtext: "",
                        icon: Icons.security,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        label: "CVV",
                        controller: cvvcontroller,
                        validator: (value) {
                          String? validationResult = validateCVV(value);
                          if (validationResult != null) {
                            return validationResult;
                          }
                          return null; // Return null for no validation errors
                        },
                      ),
                      SizedBox(
                        height: 17.h,
                      ),
                      form_fields(
                        onChanged: (value) {},
                        onclick: () {},
                        secure: false,
                        fieldtext: "",
                        icon: Icons.date_range,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.datetime,
                        label: "Expiry Date",
                        maxlength: 5,
                        controller: expiryontroller,
                        validator: (value) {
                          String? validationResult = validateExpiryDate(value);
                          if (validationResult != null) {
                            return validationResult;
                          }
                          return null; // Return null for no validation errors
                        },
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      custom_button(
                          label: 'Save',
                          backgroundcolor: ColorConstants.purple,
                          textcolor: ColorConstants.white,
                          function: (){
                            if(formKey.currentState!.validate()){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    surfaceTintColor: Colors.white,
                                    backgroundColor: Colors.white,
                                    contentPadding: EdgeInsets.only(left: 18.w, right: 18.w),
                                    actions: [
                                      TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: ColorConstants.purple,
                                          ),
                                          onPressed: () {
                                            _saveShippingAddress();
                                            Get.back();
                                          },
                                          child: Text(
                                            "Yes",
                                            style: TextStyle(
                                              color: Colors.green,
                                            ),
                                          )),
                                      TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: ColorConstants.purple,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "No",
                                            style: TextStyle(color: Colors.red),
                                          )),
                                    ],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                    title: Text(
                                      'Saving Info',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 16.sp),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Image(
                                            height: 120.h,
                                            fit: BoxFit.cover,
                                            image: const AssetImage(
                                              'assets/images/listening.gif',
                                            )),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Are you sure you want to continue?',
                                            style: TextStyle(
                                                fontSize: 13.sp, fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }else {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    CupertinoAlertDialog(
                                      title: Text(
                                        "Validation Error",
                                        style:
                                        TextStyle(color: Colors.black),
                                      ),
                                      content: Text(
                                        "Please fill in all the required fields.",
                                        style: TextStyle(
                                            color: ColorConstants.purple),
                                      ),
                                      actions: <Widget>[
                                        CupertinoDialogAction(
                                          child: Text(
                                            "Ok",
                                            style: TextStyle(
                                                color: Colors.black),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                              );
                            }
                          },
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:login_signup/views/notifications/notifications_page.dart';
// import 'package:login_signup/widgets/custom_button.dart';
//
// import '../../../../utils/color_constant.dart';
// import '../../widgets/form_fields.dart';
//
// class shipping_address extends StatefulWidget {
//   const shipping_address({Key? key}) : super(key: key);
//
//   @override
//   State<shipping_address> createState() => _shipping_addressState();
// }
//
// class _shipping_addressState extends State<shipping_address> {
//
//   final formKey = GlobalKey<FormState>();
//
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   TextEditingController namecontroller = TextEditingController();
//   TextEditingController addresscontroller = TextEditingController();
//   TextEditingController phonecontroller = TextEditingController();
//
//   TextEditingController cardcontroller = TextEditingController();
//   TextEditingController cvvcontroller = TextEditingController();
//   TextEditingController expiryontroller = TextEditingController();
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//   List<String> _notifications = [];
//   bool _hasNewNotifications = false;
//   bool _allNotificationsViewed = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUserData();
//     configureFirebaseMessaging();
//     listenToNotificationChanges();
//     requestNotificationPermissions();
//     var initializationSettingsAndroid =
//     AndroidInitializationSettings('watch');
//     var iosNotificatonDetail = DarwinInitializationSettings();
//     var initSetttings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: iosNotificatonDetail,
//
//     );
//
//     flutterLocalNotificationsPlugin.initialize(
//       initSetttings,
//       onDidReceiveNotificationResponse: (val){
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => notifications_screen())
//         );},
//     );
//   }
// // Validate card number format
//   String? validateCardNumber(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter a card number';
//     }
//     String cardNumber = value.replaceAll(RegExp(r'\D'), ''); // Remove non-digit characters
//     if (cardNumber.length != 16) {
//       return 'Card number should be 16 digits';
//     }
//     return null; // Return null for no validation errors
//   }
//
// // Format card number with slashes
//   void formatCardNumber() {
//     String value = cardcontroller.text.replaceAll(RegExp(r'\D'), '');
//     if (value.length > 4) {
//       value = value.substring(0, 4) + ' ' + value.substring(4, 8);
//     }
//     if (value.length > 9) {
//       value = value.substring(0, 9) + ' ' + value.substring(9, 13);
//     }
//     if (value.length > 14) {
//       value = value.substring(0, 14) + ' ' + value.substring(14, 16);
//     }
//     cardcontroller.text = value;
//     cardcontroller.selection = TextSelection.fromPosition(
//       TextPosition(offset: cardcontroller.text.length),
//     );
//   }
//
//
//   void requestNotificationPermissions() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     final FlutterLocalNotificationsPlugin _flutterLocalNitificationsPlugin = FlutterLocalNotificationsPlugin();
//
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
//     {
//       print("User granted permission");
//     }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
//       print("User granted provisional permission");
//
//
//     }else{
//       print("User denied permission");
//
//     }
//
//   }
//
//   Future<void> showNotification() async {
//     var android = AndroidNotificationDetails(
//       'id',
//       'channel',
//       priority: Priority.high,
//       importance: Importance.max,
//     );
//     var iosNotificatonDetail = DarwinNotificationDetails();
//     var platform = NotificationDetails(
//       android: android,
//       iOS: iosNotificatonDetail,
//     );
//
//     // Set the payload with the route of the target page
//     var payload = 'notification_page';
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Shipping Address Added',
//       'Your Shipping Address has been added.',
//       platform,
//       payload: payload,
//     );
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
//         // _showOrderNotification(title, body);
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
//       firestore
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
//   // void _showOrderNotification(String title, String body) {
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         title: Text(title),
//   //         content: Text(body),
//   //         actions: [
//   //           ElevatedButton(
//   //             child: Text('Close'),
//   //             onPressed: () {
//   //               Navigator.of(context).pop();
//   //             },
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }
//
//   void _storeNotification(String title, String body) async {
//     final user = FirebaseAuth.instance.currentUser;
//     final userId = user?.uid;
//
//     if (userId != null) {
//       try {
//         await firestore.collection('Notifications').doc(userId).collection('userNotifications').add({
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
//     final title = 'Shipping Address Added';
//     final body = 'Your Shipping Address has been added.';
//
//     // _showOrderNotification(title, body);
//     _storeNotification(title, body);
//   }
//
//   Future<void> _saveShippingAddress() async {
//     try {
//       final User? user = _auth.currentUser;
//       if (user != null) {
//         final userId = user.uid;
//
//         // Create a map with the values from the controllers
//         final addressData = {
//           'userId': userId,
//           'name': namecontroller.text,
//           'address': addresscontroller.text,
//           'phone': phonecontroller.text,
//           'cardNumber': cardcontroller.text,
//           'cvv': cvvcontroller.text,
//           'expiryDate': expiryontroller.text,
//         };
//
//         // Save the address data in the "ShippingAddress" collection
//         await _firestore.collection('ShippingAddress').doc(userId).set(addressData);
//
//         // Show a success message or perform any other desired action
//         print('Shipping address saved successfully!');
//       }
//     } catch (error) {
//       // Handle any errors that occur during the save process
//       print('Error saving shipping address: $error');
//     }
//   }
//
//   Future<void> _fetchUserData() async {
//     try {
//       final User? user = _auth.currentUser;
//       if (user != null) {
//         final userId = user.uid;
//
//         // Fetch the user's shipping address data
//         final addressSnapshot = await _firestore
//             .collection('ShippingAddress')
//             .doc(userId)
//             .get();
//
//         if (addressSnapshot.exists) {
//           // If the address data exists, populate the text fields with the data
//           final addressData = addressSnapshot.data() as Map<String, dynamic>;
//           namecontroller.text = addressData['name'];
//           addresscontroller.text = addressData['address'];
//           phonecontroller.text = addressData['phone'];
//           cardcontroller.text = addressData['cardNumber'];
//           cvvcontroller.text = addressData['cvv'];
//           expiryontroller.text = addressData['expiryDate'];
//         }
//       }
//     } catch (error) {
//       // Handle any errors that occur during the data fetching process
//       print('Error fetching user data: $error');
//     }
//   }
//
//
//   // @override
//   // void dispose() {
//   //   namecontroller.dispose();
//   //   addresscontroller.dispose();
//   //   phonecontroller.dispose();
//   //   cardcontroller.dispose();
//   //   cvvcontroller.dispose();
//   //   expiryontroller.dispose();
//   //   super.dispose();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorConstants.grey,
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           "Shipping Information",
//           style: TextStyle(
//             fontSize: 18,
//             color: ColorConstants.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: ColorConstants.grey,
//         iconTheme: IconThemeData(
//           color: ColorConstants.black,
//         ),
//       ),
//       body: Center(
//         child: Container(
//           width: Get.width / 1.2,
//           height: Get.height / 1.3,
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(20)),
//             ),
//             elevation: 10,
//             child: Padding(
//               padding: EdgeInsets.only(left: 30, right: 30, top: 10.h),
//               child: Form(
//                 key: formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       form_fields(
//                         onChanged: (value) {},
//                         onclick: () {},
//                         secure: false,
//                         fieldtext: "",
//                         icon: Icons.person_outline_rounded,
//                         label: "Name",
//                         controller: namecontroller,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter name';
//                           }
//                           // Additional validation logic can be added here
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       form_fields(
//                         onChanged: (value) {},
//                         onclick: () {},
//                         secure: false,
//                         fieldtext: "",
//                         icon: Icons.location_city_outlined,
//                         label: "Address",
//                         controller: addresscontroller,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter address';
//                           }
//                           // Additional validation logic can be added here
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       TextFormField(
//                         controller: cardcontroller,
//                         keyboardType: TextInputType.number,
//                         textInputAction: TextInputAction.next,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly,
//                         ],
//                         decoration: InputDecoration(
//                           labelText: 'Card Number',
//                         ),
//                         maxLength: 19,
//                         validator: (value) => validateCardNumber(value),
//                         onChanged: (value) {
//                           formatCardNumber();
//                         },
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       form_fields(
//                         onChanged: (value) {},
//                         onclick: () {},
//                         secure: false,
//                         fieldtext: "",
//                         icon: Icons.security,
//                         label: "CVV",
//                         controller: cvvcontroller,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter card cvv';
//                           }
//                           // Additional validation logic can be added here
//                           return null;
//                         },
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       form_fields(
//                         onChanged: (value) {},
//                         onclick: () {},
//                         secure: false,
//                         fieldtext: "",
//                         icon: Icons.date_range,
//                         label: "Expiry Date",
//                         controller: expiryontroller,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter epiry date of card';
//                           }
//                           // Additional validation logic can be added here
//                           return null;
//                         },
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       custom_button(
//                         label: 'Save',
//                         backgroundcolor: ColorConstants.purple,
//                         textcolor: ColorConstants.white,
//                         function: (){
//                           if(formKey.currentState!.validate()){
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   contentPadding: EdgeInsets.only(left: 18.w, right: 18.w),
//                                   actions: [
//                                     TextButton(
//                                         style: TextButton.styleFrom(
//                                           foregroundColor: ColorConstants.purple,
//                                         ),
//                                         onPressed: () {
//                                           _saveShippingAddress();
//                                           _handleConfirmOrder();
//                                           showNotification();
//                                           Get.back();
//                                         },
//                                         child: Text(
//                                           "Yes",
//                                           style: TextStyle(
//                                             color: Colors.green,
//                                           ),
//                                         )),
//                                     TextButton(
//                                         style: TextButton.styleFrom(
//                                           foregroundColor: ColorConstants.purple,
//                                         ),
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Text(
//                                           "No",
//                                           style: TextStyle(color: Colors.red),
//                                         )),
//                                   ],
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(15),
//                                     ),
//                                   ),
//                                   title: Text(
//                                     'Accepting Order',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold, fontSize: 16.sp),
//                                   ),
//                                   content: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: <Widget>[
//                                       Image(
//                                           height: 120.h,
//                                           fit: BoxFit.cover,
//                                           image: const AssetImage(
//                                             'assets/images/listening.gif',
//                                           )),
//                                       Container(
//                                         alignment: Alignment.center,
//                                         child: Text(
//                                           'Are you sure you want to continue?',
//                                           style: TextStyle(
//                                               fontSize: 13.sp, fontWeight: FontWeight.w600),
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             );
//                           }else {
//                             showDialog(
//                               context: context,
//                               builder: (context) =>
//                                   CupertinoAlertDialog(
//                                     title: Text(
//                                       "Validation Error",
//                                       style:
//                                       TextStyle(color: Colors.black),
//                                     ),
//                                     content: Text(
//                                       "Please fill in all the required fields.",
//                                       style: TextStyle(
//                                           color: ColorConstants.purple),
//                                     ),
//                                     actions: <Widget>[
//                                       CupertinoDialogAction(
//                                         child: Text(
//                                           "Ok",
//                                           style: TextStyle(
//                                               color: Colors.black),
//                                         ),
//                                         onPressed: () {
//                                           Navigator.of(context).pop();
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                             );
//                           }
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
