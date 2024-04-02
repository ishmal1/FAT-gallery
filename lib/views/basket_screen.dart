import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login_signup/views/checkout_screen.dart';
import 'package:login_signup/views/notifications/notifications_page.dart';
import '../../../utils/color_constant.dart';
import '../../widgets/custom_button.dart';
import '../utils/image_constant.dart';

class FineArt {
  final String name;
  final String id;
  final String artist;
  final String imageUrl;
  final double price;
  int quantity;

  FineArt({
    required this.name,
    required this.id,
    required this.artist,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });
}

class BasketScreen extends StatefulWidget {
  final String dishId;
  final String restaurantId;


  const BasketScreen({Key? key, required this.dishId, required this.restaurantId}) : super(key: key);

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  List<Map<String, dynamic>> checkoutItems = [];

  int calculateTotalItems(List<dynamic> cartItems) {
    int totalItems = 0;
    for (var cartItem in cartItems) {
      final quantity = cartItem['quantity'] as int? ?? 1;
      totalItems += quantity;
    }
    return totalItems;
  }

  List<FineArt> fineArts = [
    FineArt(
      id: "1",
      quantity: 2,
      name: 'Mona Lisa',
      artist: 'Leonardo da Vinci',
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/800px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg',
      price: 1000000.00,
    ),
    FineArt(
      id: "2",
      quantity: 1,
      name: 'Starry Night',
      artist: 'Vincent van Gogh',
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/800px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg',
      price: 1500000.00,
    ),
    // Add more fine arts here...
  ];








  @override
  Widget build(BuildContext context) {
    double totalPrice = 0.0;

    // Calculate total price based on quantities and prices of items
    for (var fineArt in fineArts) {
      totalPrice += fineArt.price * fineArt.quantity;
    }


    return Scaffold(
      backgroundColor: ColorConstants.grey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ColorConstants.black,
        ),
        title: Text(
          "Basket",
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 18.sp, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: ColorConstants.grey,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: ColorConstants.bckColor,
                    borderRadius: BorderRadius.circular(10)),
                width: 250.w,
                height: 30.h,
                child: Padding(
                  padding: EdgeInsets.only(left: 7.w, right: 7.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(
                          width: 16.w,
                          height: 15.h,
                          image: AssetImage(ImageConstant.bell)),
                      SizedBox(width: 10.w,),
                      Text(
                        "Delivery for FREE until the end of the month.",
                        style: TextStyle(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: fineArts.length,
                          itemBuilder: (BuildContext context, int index) {

                            final fineArt = fineArts[index];
                            return Container(
                              margin: EdgeInsets.only(top: 10.h),
                              child: Slidable(
                                closeOnScroll: true,
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
                                                'Clearing Basket',
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
                                      icon: Icons.delete,
                                      backgroundColor: Colors.red,
                                      label: "Delete",
                                      borderRadius: BorderRadius.circular(5),
                                      autoClose: true,
                                    ),
                                  ],
                                ),
                                child: Container(
                                  width: 314.w,
                                  height: 90.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15.w, right: 15.w),
                                    child: Row(
                                      children: [
                                        fineArt.imageUrl.isEmpty ? Image(
                                            width: 80.w,
                                            height: 70.h,
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                ImageConstant.watch)) : Image(
                                            width: 80.w,
                                            height: 70.h,
                                            fit: BoxFit.cover,
                                            image: NetworkImage(fineArt.imageUrl)),

                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10.w,
                                              top: 16.h,
                                              bottom: 16.h),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                fineArt.name,
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Text(
                                                "\$ ${fineArt.price.toStringAsFixed(2)}"
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    color: ColorConstants
                                                        .purple),
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Quantity",
                                                    style: TextStyle(
                                                        fontSize: 9.sp,
                                                        fontWeight:
                                                        FontWeight
                                                            .w400),
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        // Decrease quantity
                                                        if (fineArt.quantity > 1) {
                                                          fineArt.quantity -= 1;
                                                        }
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 15.h,
                                                      width: 15.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              4),
                                                          color:
                                                          ColorConstants
                                                              .btnColor),
                                                      child: Center(
                                                          child: Text(
                                                            "-",
                                                            style: TextStyle(
                                                                fontSize: 10.sp,

                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          )),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Text(
                                                    fineArt.quantity.toString(),
                                                    style: TextStyle(
                                                        fontSize: 9.sp,
                                                        fontWeight:
                                                        FontWeight
                                                            .w600),
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        // Increase quantity
                                                        fineArt.quantity += 1;
                                                      });

                                                    },
                                                    child: Container(
                                                      height: 15.h,
                                                      width: 15.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              4),
                                                          color:
                                                          ColorConstants
                                                              .btnColor),
                                                      child: Center(
                                                          child: Text(
                                                            "+",
                                                            style: TextStyle(
                                                                fontSize: 10.sp,

                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 25.w,
                          right: 25.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Total",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '\$${totalPrice.toStringAsFixed(2)}'
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstants.purple),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: Center(
                  child: SizedBox(
                    width: 310.w,
                    height: 45.h,
                    child: custom_button(
                        function: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) =>
                              checkout_screen(checkoutItems: checkoutItems),));

                        },
                        label: 'Checkout',
                        backgroundcolor: ColorConstants.purple,
                        textcolor: ColorConstants.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
