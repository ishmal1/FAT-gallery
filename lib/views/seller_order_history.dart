import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../utils/color_constant.dart';

class FineArt {
  final String name;
  final String id;
  final String artist;
  final String imageUrl;
  final double price;
  final String order;
  int quantity;
  final DateTime dateTime;

  FineArt({
    required this.name,
    required this.id,
    required this.artist,
    required this.imageUrl,
    required this.price,
    required this.order,
    required this.quantity,
    required this.dateTime,
  });
}



class seller_order_history extends StatefulWidget {
  const seller_order_history({key});

  @override
  State<seller_order_history> createState() => _seller_order_historyState();
}

class _seller_order_historyState extends State<seller_order_history> {
  List<FineArt> fineArts = [
    FineArt(
      id: "1",
      quantity: 2,
      name: 'Mona Lisa',
      artist: 'Leonardo da Vinci',
      order: 'Pending',
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/800px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg',
      price: 1000000.00,
      dateTime: DateTime.now(),
    ),
    FineArt(
      id: "2",
      quantity: 1,
      order: 'Accepted',
      name: 'Starry Night',
      artist: 'Vincent van Gogh',
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/800px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg',
      price: 1500000.00,
      dateTime: DateTime.now(),
    ),
    // Add more fine arts here...
  ];
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final User? currentUser = _auth.currentUser;
    final String userId = currentUser?.uid ?? '';
    return Scaffold(
      backgroundColor: ColorConstants.grey,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Order History",
          style: TextStyle(
            color: ColorConstants.black,
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorConstants.grey,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: ColorConstants.black,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w,right: 20.w),
        child: ListView.builder(
            itemCount: fineArts.length,
            itemBuilder: (BuildContext context, int index) {
              final fineArt = fineArts[index];
              return Container(
                margin: EdgeInsets.only(top: 10.h),
                child: Slidable(
                  closeOnScroll: true,
                  startActionPane: ActionPane(
                    extentRatio: 0.3,
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
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
                                        // document.reference.update({'order': 'Rejected'});

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
                                  'Accepting Order',
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
                        },
                        icon: Icons.close,
                        backgroundColor: Colors.red,
                        label: "Reject",
                        borderRadius: BorderRadius.circular(5),
                        autoClose: true,
                      ),

                    ],
                  ),
                  endActionPane: ActionPane(
                    extentRatio: 0.3,
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
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
                                        // document.reference.update({'order': 'Accepted'});
                                        // showNotification();
                                        // _handleConfirmOrder();

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
                                  'Accepting Order',
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
                        },
                        icon: Icons.check,
                        backgroundColor: Colors.green,
                        label: "Accept",
                        borderRadius: BorderRadius.circular(5),
                        autoClose: true,
                      ),
                    ],
                  ),
                  child: Container(
                    width: 314.w,
                    height: 105.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 15.w, right: 15.w),
                      child: Row(
                        children: [
                          Image(
                              width: 80.w,
                              height: 80.h,
                              fit: BoxFit.cover,
                              image: NetworkImage(fineArt.imageUrl)),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10.w,
                                top: 12.h,
                                bottom: 12.h),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Text(
                                    fineArt.order,
                                    style: fineArt.order== "Pending" ? TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.red,
                                        fontWeight:
                                        FontWeight.w600) : TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.green,
                                        fontWeight:
                                        FontWeight.w600)
                                ),
                                Text(
                                  fineArt.name,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight:
                                      FontWeight.w600),
                                ),
                                Text(
                                  "\$${fineArt.price}"
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight:
                                      FontWeight.w600,
                                      color: ColorConstants
                                          .purple),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Quantity",
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight:
                                          FontWeight
                                              .w400),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      fineArt.quantity.toString(),
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight:
                                          FontWeight
                                              .w600),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${fineArt.dateTime.toString()}",
                                  style: TextStyle(
                                      fontSize: 8.sp,
                                      fontWeight:
                                      FontWeight.w600,
                                      color: ColorConstants
                                          .black),
                                ),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
        )
      ),
    );
  }
}



