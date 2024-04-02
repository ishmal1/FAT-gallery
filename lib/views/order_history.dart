import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../utils/color_constant.dart';
import '../utils/image_constant.dart';
import '../widgets/custom_button.dart';

class order_history_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.grey,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Order History",
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
      body: OrderHistoryList(),
    );
  }
}

class OrderHistoryList extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(left: 20.w,right: 20.w,bottom: 10.h),
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('OrderHistory')
            .doc("userId")
            .collection('items')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading..."));
          }

          if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return Padding(
              padding: EdgeInsets.only(top: 40.h),
              child: Center(
                child: Column(
                  children: [
                    Image(
                        width: 323.w,
                        height: 323.h,
                        image: AssetImage(ImageConstant.order,)),
                    SizedBox(
                        width: 182.w,
                        height: 33.h,
                        child: Text("No history yet",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 27.sp),)),
                    SizedBox(
                        width: 217.w,
                        height: 48.h,
                        child: Column(
                          children: [
                            Text("Hit the orange button down ",style: TextStyle(color: Colors.black.withOpacity(0.57),fontWeight: FontWeight.w400,fontSize: 15.sp),),
                            Text("below to Create an order.",style: TextStyle(color: Colors.black.withOpacity(0.57),fontWeight: FontWeight.w400,fontSize: 15.sp),)

                          ],
                        )),
                    custom_button(label: "Start ordering", backgroundcolor: ColorConstants.btnColor, textcolor: Colors.white, function: (){})
                  ],
                ),
              ),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              List<dynamic> images = data['images'] as List<dynamic>;
              String firstImage = images.isNotEmpty ? images[0] as String : '';
              final timestamp = data['ordered at'] as Timestamp;
              final dateTime = timestamp.toDate();

              return Container(
                margin: EdgeInsets.only(top: 10.h),
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
                            image: CachedNetworkImageProvider(firstImage)),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10.w,
                              top: 15.h,
                              bottom: 15.h),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Text(
                                data['order'],
                                style: data["order"] == "Pending" ? TextStyle(
                                    fontSize: 8.sp,
                                    color: Colors.red,
                                    fontWeight:
                                    FontWeight.w600) : TextStyle(
                                    fontSize: 8.sp,
                                    color: Colors.green,
                                    fontWeight:
                                    FontWeight.w600)
                              ),
                              Text(
                                data['dishName'],
                                style: TextStyle(
                                    fontSize: 9.sp,
                                    fontWeight:
                                    FontWeight.w600),
                              ),
                              Text(
                                "\$${data['price']}"
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 6.sp,
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
                                        fontSize: 6.sp,
                                        fontWeight:
                                        FontWeight
                                            .w400),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    data['quantity'].toString(),
                                    style: TextStyle(
                                        fontSize: 6.sp,
                                        fontWeight:
                                        FontWeight
                                            .w600),
                                  ),
                                ],
                              ),
                              Text(
                                "${dateTime.toString()}",
                                style: TextStyle(
                                    fontSize: 6.sp,
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
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
