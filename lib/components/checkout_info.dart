import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/image_constant.dart';
import '../views/checkout_screen.dart';

// ignore: camel_case_types
class checkout_info extends StatelessWidget {
  const checkout_info({
    key,
  });

  @override
  Widget build(BuildContext context) {
      return SizedBox(
          width: Get.width,
          child: Card(
            surfaceTintColor: Colors.white,
            color: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Padding(
              padding:
              EdgeInsets.only(top: 9.h, left: 22.w, right: 22.w, bottom: 18.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  info(url: ImageConstant.profile, text: "Faizan Ahmed"),
                  info(url: ImageConstant.gps, text: "Abid Town Narowal"),
                  info(url: ImageConstant.call, text: "03034992416"),
                ],
              )
            ),
          ));
  }
}
