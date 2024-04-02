import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: camel_case_types, must_be_immutable
class admin_custom_button extends StatelessWidget {
  admin_custom_button(
      {key,
        required this.label,
        required this.backgroundcolor,
        required this.textcolor,
        required this.function});

  String label;
  Color backgroundcolor;
  Color textcolor;
  VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundcolor,
          minimumSize: Size(260.w, 40.h),
          maximumSize: Size(260.w, 40.h),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          elevation: 30,
        ),
        onPressed: function,
        child: Text(
          label,
          style: TextStyle(
              fontSize: 5.sp,
              color: textcolor,fontWeight: FontWeight.w700),
        ));
  }
}
