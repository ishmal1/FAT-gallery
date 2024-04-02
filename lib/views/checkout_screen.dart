import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:login_signup/views/success_page/success_page_view.dart';
import '../../widgets/bottom_sheet.dart';
import '../components/checkout_info.dart';
import '../components/payment_methods.dart';
import '../shipping_address.dart';
import '../utils/color_constant.dart';
import '../utils/image_constant.dart';
import '../widgets/custom_button.dart';
import 'notifications/notifications_page.dart';

// ignore: camel_case_types
class checkout_screen extends StatefulWidget {
  final List<Map<String, dynamic>> checkoutItems;
  const checkout_screen({key, required this.checkoutItems});

  @override
  State<checkout_screen> createState() => _checkout_screenState();
}

// ignore: camel_case_types
class _checkout_screenState extends State<checkout_screen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _updateStatus() async {
    final User? currentUser = _auth.currentUser;
    final String userId = currentUser?.uid ?? '';

    // Check if the user has a shipping address
    final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('ShippingAddress')
        .doc(userId)
        .get();

    final Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;
    final shippingAddress = userData?['address'];
    final shippingName = userData?['name'];
    final shippingPhone = userData?['phone'];
    if (shippingAddress == null) {
      // Show dialog to fill out shipping address
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Shipping Address'),
            content: Text('Please fill out your shipping address.'),
            actions: [
              TextButton(
                onPressed: () {
                  // Close the dialog
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // User has a shipping address, update documents
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Checkout')
        .doc(userId)
        .collection('items')
        .get();

    final batchUpdate = FirebaseFirestore.instance.batch();

    querySnapshot.docs.forEach((doc) {
      final DocumentReference docRef = doc.reference;
      batchUpdate.set(
        docRef,
        {
          'status': true,
          'shippingAddress': shippingAddress,
          'shippingName': shippingName,
          'shippingPhone': shippingPhone,
        },
        SetOptions(merge: true), // Use SetOptions to merge with existing fields
      );
    });

    await batchUpdate.commit();
  }
  List<String> cards = [
    ImageConstant.visa,
    ImageConstant.cod,
    ImageConstant.stripe
  ];
  String formatCardNumber(String input) {
    final maskedNumber = '**** **** **** ${input.substring(input.length - 4)}';
    return maskedNumber.replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ');
  }

  TextEditingController cardNumber = TextEditingController();
  TextEditingController expireDate = TextEditingController();
  TextEditingController cvv = TextEditingController();

  String? value;
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> dummyItems = [
      {
        'artName': 'Mona Lisa',
        'price': '5.99',
        'quantity': 2,
      },
      {
        'artName': 'Starry Night',
        'price': '2.49',
        'quantity': 3,
      },
      {
        'artName': 'The Scream',
        'price': '1.99',
        'quantity': 1,
      },
    ];

    double totalPrice = 0.0;
    int totalQuantity = 0;

    for (var item in dummyItems) {
      final price = double.tryParse(item['price'] as String? ?? '') ?? 0.0;
      final quantity = item['quantity'] as int? ?? 0;

      totalPrice += (price * quantity);
      totalQuantity += quantity;
    }
    return Stack(
        children: [
      Scaffold(
        backgroundColor: ColorConstants.grey,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          surfaceTintColor: Colors.white,
          iconTheme: IconThemeData(
            color: ColorConstants.black,
          ),
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            "Checkout",
            style: TextStyle(
              fontSize: 18.sp,
              color: ColorConstants.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: ColorConstants.grey,
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 4.w,right: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Shipping information",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(const shipping_address());
                        },
                        child: Text(
                          "change",
                          style: TextStyle(
                              color: ColorConstants.purple, fontSize: 11.sp,fontWeight: FontWeight.w600),
                        ))
                  ],
                ),
              ),
              checkout_info(),
              SizedBox(
                height: 10.h,
              ),

              Padding(
                padding: EdgeInsets.only(left: 5,right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Payment Method",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "",
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                width: Get.width,
                child: Card(
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 7.h, left: 7.w, right: 15.w, bottom: 7.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        payment_method(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 5,right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "List of Items",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: dummyItems.length,
                  itemBuilder: (context, index) {
                    final item = dummyItems[index];
                    final artName = item['artName'] as String;
                    final price = item['price'].toString();
                    final quantity = item['quantity'] as int;

                    return SizedBox(
                      width: Get.width,
                      child: Card(
                        surfaceTintColor: Colors.white,
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Slidable(
                          closeOnScroll: true,
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            dragDismissible: true,
                            extentRatio: 0.25,
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
                                              // FirebaseFirestore.instance
                                              //     .collection('Checkout')
                                              //     .doc(userId)
                                              //     .collection('items')
                                              //     .doc(snapshot.data!.docs[index].id)
                                              //     .delete();
                                              Get.back();
                                              // itemDocs[index].reference.delete();
                                              // Get.back();
                                            },
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
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
                                            ),
                                          ),
                                        ],
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                        ),
                                        title: Text(
                                          'Clearing Checkout List',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Image(
                                              height: 120.h,
                                              fit: BoxFit.cover,
                                              image: const AssetImage(
                                                'assets/images/listening.gif',
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Are you sure you want to continue?',
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
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
                                borderRadius: BorderRadius.circular(15),
                                autoClose: true,
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(artName,style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w600),),
                            subtitle: Text('Price: $price, Quantity: $quantity',style: TextStyle(fontSize: 9.sp),),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Total",
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "\$${totalPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue, // Change color as needed
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: custom_button(
                    function: () async {
                      if (cardvalue == 'stripe') {
                        _updateStatus();
                        showModalBottomSheet(
                          backgroundColor: Colors.white,
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                          ),
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return Container(
                              padding: EdgeInsets.only(left: 15.w,right: 15.w,top: 15.h,bottom: 15.h),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 50.w,
                                    child: const Divider(
                                      color: Color(0xff5956E9),
                                      thickness: 4,
                                    ),
                                  ),
                                  SizedBox(height: 35.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [
                                      Text(
                                        'Stripe Payment',
                                        style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
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
                                            "${totalQuantity}",
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )

                                    ],
                                  ),
                                  SizedBox(height: 14.h),
                                  TextFormField(
                                    style: TextStyle(fontSize: 8.sp),
                                    controller: cardNumber,
                                    decoration: InputDecoration(
                                        labelText: 'Card Number',
                                        labelStyle: TextStyle(fontSize: 8.sp)

                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          style: TextStyle(fontSize: 8.sp),
                                          controller: expireDate,
                                          decoration: InputDecoration(
                                              labelText: 'Expiry Date',
                                              labelStyle: TextStyle(fontSize: 8.sp)
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 14.w),
                                      Expanded(
                                        child: TextFormField(
                                          style: TextStyle(fontSize: 8.sp),

                                          controller: cvv,
                                          decoration: InputDecoration(
                                              labelText: 'CVV',
                                              labelStyle: TextStyle(fontSize: 8.sp)
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                          "\$${totalPrice.toStringAsFixed(2)}",
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Color(0xff5956E9),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),


                                  SizedBox(height: 14.h),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorConstants.purple,
                                      minimumSize: Size(260.w, 40.h),
                                      maximumSize: Size(260.w, 40.h),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10))),
                                      elevation: 30,
                                    ),
                                    onPressed: () {
                                      if(cardNumber.text == '1122112211221122' && cvv.text == '123' && expireDate.text == '1/12') {
                                        Get.to(success_page());
                                      } else {
                                        print('click');
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text("Invalid Card Details"),
                                        ));
                                      }
                                      // Perform the Stripe payment process here
                                      // You can use the `stripe_payment` package or integrate with the Stripe API.
                                    },
                                    child: custom_button(
                                      label: 'Make Payment',
                                      backgroundcolor: ColorConstants.purple,
                                      textcolor: Colors.white,
                                      function: () async {
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                      else if (cardvalue == 'card'){
                        _updateStatus();

                        showModalBottomSheet(
                            elevation: 0,
                            context: context,
                            backgroundColor: Colors.white,
                            builder: (context) {
                              print(totalQuantity);
                              print(totalPrice);

                              return Bottom_sheet(
                                background: ColorConstants.visa_card_color,
                                cardlogo: ImageConstant.visa,
                                checkoutItems: widget.checkoutItems,
                                quantity: totalQuantity,
                                price: totalPrice,
                              );
                            });

                        // Handle other payment methods
                      }
                      else if (cardvalue == "Cash on Delivery"){
                        _updateStatus();
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),

                          ),
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return Container(
                              padding: EdgeInsets.only(left: 15.w,right: 15.w,top: 15.h,bottom: 15.h),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 45.w,
                                    child: const Divider(
                                      color: Color(0xff5956E9),
                                      thickness: 3,
                                    ),
                                  ),

                                  SizedBox(height: 35.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [
                                      Text(
                                        'Total Payment',
                                        style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
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
                                            "${totalQuantity}",
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )

                                    ],
                                  ),
                                  SizedBox(height: 15.h),
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
                                          "\$${totalPrice.toStringAsFixed(2)}",
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Color(0xff5956E9),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 35.h),


                                  custom_button(
                                    label: 'Pay Cash on Delivery',
                                    backgroundcolor: ColorConstants.purple,
                                    textcolor: Colors.white,
                                    function: () async {
                                      Get.to(success_page());
                                    },
                                  ),
                                  SizedBox(height: 35.h),

                                ],
                              ),
                            );
                          },



                        );}
                      // Get.to(CheckoutScreen());

                    },
                    label: "Confirm and Pay",
                    backgroundcolor: ColorConstants.purple,
                    textcolor: ColorConstants.white),
              ),
              SizedBox(
                height: 10.h,
              ),


            ],
          ),
        )),
      ),
    ]);
  }
}

// ignore: camel_case_types, must_be_immutable
class info extends StatelessWidget {
  info({key, required this.url, required this.text});

  String text;
  String url;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 7.h),
      child: Row(
        children: [
          Image(image: AssetImage(url)),
          SizedBox(
            width: 18.w,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 9.sp),
          ),
        ],
      ),
    );
  }
}
