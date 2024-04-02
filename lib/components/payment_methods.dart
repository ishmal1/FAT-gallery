import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:overlay_support/overlay_support.dart';
import '../../../../utils/image_constant.dart';
import '../utils/color_constant.dart';
import '../views/success_page/success_page_view.dart';
import '../views/success_page/widgets/router_text.dart';
import '../widgets/custom_button.dart';

// ignore: camel_case_types
class payment_method extends StatefulWidget {
  const payment_method({key});

  @override
  State<payment_method> createState() => _payment_method();
}

String? cardvalue;

// ignore: camel_case_types
class _payment_method extends State<payment_method> {
  List<String> cards = [
    ImageConstant.visa,
    ImageConstant.cod,
    ImageConstant.stripe
  ];

  String formatCardNumber(String input) {
    final maskedNumber = '**** **** **** ${input.substring(input.length - 4)}';
    return maskedNumber.replaceAllMapped(RegExp(r'.{5}'), (match) => '${match.group(0)} ');
  }

TextEditingController cardNumber = TextEditingController();
  TextEditingController expireDate = TextEditingController();
  TextEditingController cvv = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: Get.width / 2.5,
              child: RadioListTile(
                title: SizedBox(
                  width: 55.w,
                  height: 35.h,
                  child: Image(
                    fit: BoxFit.contain,
                    width: 55.w,
                    height: 35.h,
                    image: AssetImage(cards[0]),
                  ),
                ),
                value: "card",
                groupValue: cardvalue,
                onChanged: (value) {
                  setState(() {
                    print('cardvalue : $value');
                    cardvalue = value.toString();
                    print('cardvalue : $cardvalue');
                  });
                },
              ),
            ),
            Text(formatCardNumber("4242424242424242"),style: TextStyle(fontSize: 12.sp),),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: Get.width / 2.5,
              child: RadioListTile(
                title: SizedBox(
                  width: 55.w,
                  height: 35.h,
                  child: Image(
                    fit: BoxFit.contain,
                    width: 55.w,
                    height: 35.h,
                    image: AssetImage(cards[1]),
                  ),
                ),
                value: "Cash on Delivery",
                groupValue: cardvalue,
                onChanged: (value) {
                  setState(() {
                    print('Cash on Delivery" : $value');
                    cardvalue = value.toString();
                    print('Cash on Delivery" : $cardvalue');
                  });
                },
              ),
            ),
            Text("Cash on Delivery",style: TextStyle(fontSize: 12.sp)),

          ],
        ),
        Row(
          children: [
            SizedBox(
              width: Get.width / 2.5,
              child: RadioListTile(
                title: SizedBox(
                  width: 55.w,
                  height: 35.h,
                  child: Image(
                    fit: BoxFit.contain,
                    width: 55.w,
                    height: 35.h,
                    image: AssetImage(cards[2]),
                  ),
                ),
                value: "stripe",
                groupValue: cardvalue,
                onChanged: (value) {
                  setState(() {
                    print('cardvalue : $value');
                    cardvalue = value.toString();
                    // openStripePaymentSheet(context);
                    print('cardvalue : $cardvalue');
                  });
                },
              ),
            ),
            Text("",style: TextStyle(fontSize: 12.sp)),
          ],
        ),
      ],
    );
  }
}
