import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: camel_case_types, must_be_immutable
class profile_card_widget extends StatelessWidget {
  profile_card_widget({key, required this.text, required this.function});

  String text;
  VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height / 14,
      child: InkWell(
        onTap: function,
        child: Card(
          surfaceTintColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(
                      fontSize: 12.sp, fontWeight: FontWeight.w600),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 18.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
