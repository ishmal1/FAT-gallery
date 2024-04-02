import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_signup/views/Seller%20Screens/seller_Dashboard_screen.dart';

import '../../../../utils/color_constant.dart';
import '../../utils/image_constant.dart';
import '../../widgets/custom_button.dart';
import '../login/login_page.dart';
import '../connectivity_wrapper.dart';

// ignore: camel_case_types
class splash_screen extends StatefulWidget {
  const splash_screen({key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

// ignore: camel_case_types
class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  ConnectivityWrapper(child: LoginPage(),),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.purple,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 25.w,right: 25.w,top: 25.h,bottom: 25.h),
          child: Column(
            children: [
              Text(
                "Find your Art Work",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40.sp,
                  color: ColorConstants.white,
                ),
              ),
              Expanded(child: Image(image: AssetImage(ImageConstant.splashPic))),
              SizedBox(
                height: 25.h,
              ),
              custom_button(
                  function: () {
                    // ConnectivityWrapper(child: LoginPage(),);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));

                  },
                  label: 'Get Started',
                  backgroundcolor: ColorConstants.white,
                  textcolor: ColorConstants.purple),
            ],
          ),
        ),
      ),
    );
  }
}
