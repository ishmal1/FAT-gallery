import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login_signup/utils/GlobalVariable.dart';
import 'package:login_signup/utils/strings/app_string.dart';

import '../components/payment_methods.dart';
import '../utils/color_constant.dart';

class cards_screen extends StatelessWidget {
  const cards_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.grey,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Payment Methods",
          style: TextStyle(
            color: ColorConstants.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorConstants.grey,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: ColorConstants.black,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15.w,right: 15.w,top: 10.h),
        child: Column(
          children: [
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
                      top: 7.h, left: 7.w, right: 15.w, bottom: 15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  <Widget>[
                      payment_method(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
