import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/color_constant.dart';
import '../views/flip_card_widget.dart';
import '../views/notifications/notifications_page.dart';
import '../views/order_history.dart';
import '../views/success_page/success_page_view.dart';
import 'custom_button.dart';

class Bottom_sheet extends StatefulWidget {
  final int quantity;
  final double price;
  final List<Map<String, dynamic>> checkoutItems;
  Color background;
  String cardlogo;
  Bottom_sheet({key, required this.quantity, required this.price, required this.checkoutItems, required this.background, required this.cardlogo,});

  @override
  State<Bottom_sheet> createState() => _Bottom_sheetState();
}

class _Bottom_sheetState extends State<Bottom_sheet> {


  @override
  Widget build(BuildContext context) {

    return Card(
      surfaceTintColor: Colors.white,
      color: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Padding(
        padding: EdgeInsets.only( left: 15.w, right: 15.w),
        child: Column(
          children: [
            SizedBox(
              width: 45.w,
              child: const Divider(
                color: Color(0xff5956E9),
                thickness: 3,
              ),
            ),
            SizedBox(height: 35.h,),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Confirm and Pay',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Products: ",
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),

                      ),
                      Text(
                        "${widget.quantity}",
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            CreditCardFlip(),
            Padding(
              padding: EdgeInsets.only(top: 25.h, right: 25.w, left: 25.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 11.sp),
                  ),
                  Text(
                    "\$${widget.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Color(0xff5956E9),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            custom_button(
                label: 'Pay Now',
                backgroundcolor: ColorConstants.purple,
                textcolor: ColorConstants.white,
                function: () async {
                  Get.to(success_page());
                })],
        ),
      ),
    );
  }
}

// ignore: camel_case_types, must_be_immutable
// class Bottom_sheet extends StatelessWidget {
//
//   final int quantity;
//   final double price;
//   final List<Map<String, dynamic>> checkoutItems;
//   Bottom_sheet({key, required this.background, required this.cardlogo, required this.checkoutItems, required this.quantity, required this.price});
//
//   Color background;
//   String cardlogo;
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//     Future<void> _addToOrderHistory() async {
//       final User? currentUser = _auth.currentUser;
//       final String userId = currentUser?.uid ?? '';
//
//       final CollectionReference checkoutCollection = _firestore
//           .collection('Checkout')
//           .doc(userId)
//           .collection('items');
//
//       final QuerySnapshot querySnapshot = await checkoutCollection.get();
//
//       final batchUpdate = _firestore.batch();
//
//       querySnapshot.docs.forEach((doc) {
//         final DocumentReference docRef = _firestore
//             .collection('OrderHistory')
//             .doc(userId)
//             .collection('items')
//             .doc();
//
//         final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//         data['status'] = true;
//         data['order'] = 'Pending';
//         data["ordered at"] = FieldValue.serverTimestamp();
//
//         batchUpdate.set(docRef, data);
//
//         batchUpdate.delete(doc.reference);
//       });
//
//       await batchUpdate.commit();
//     }
//
//     final FirebaseAuth auth = FirebaseAuth.instance;
//     final User? currentUser = auth.currentUser;
//     final String userId = currentUser?.uid ?? '';
//
//     return Card(
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(30), topRight: Radius.circular(30))),
//       child: Padding(
//         padding: const EdgeInsets.only( left: 20, right: 20),
//         child: Column(
//           children: [
//             SizedBox(
//               width: 50,
//               child: const Divider(
//                 color: Color(0xff5956E9),
//                 thickness: 3,
//               ),
//             ),
//             SizedBox(height: 40,),
//             Padding(
//               padding: EdgeInsets.only(left: 20,right: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   const Text(
//                     'Confirm and Pay',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Row(
//                     children: <Widget>[
//                       Text(
//                         "Products: ",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//
//                       ),
//                       Text(
//                         "$quantity",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             CreditCardFlip(),
//             Padding(
//               padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     "Total",
//                     style: TextStyle(fontSize: 17),
//                   ),
//                   Text(
//                     "\$${price.toStringAsFixed(2)}",
//                     style: TextStyle(
//                       fontSize: 22,
//                       color: Color(0xff5956E9),
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             custom_button(
//                 label: 'Pay Now',
//                 backgroundcolor: ColorConstants.purple,
//                 textcolor: ColorConstants.white,
//                 function: () async {
//                   await _addToOrderHistory();
//                   Get.to(success_page());
//                 })],
//         ),
//       ),
//     );
//   }
// }
