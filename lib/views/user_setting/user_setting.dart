import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_signup/firebase/firestore_fetch_data/fetch_user_data.dart';
import 'package:login_signup/shipping_address.dart';
import 'package:login_signup/views/order_history.dart';
import 'package:share_plus/share_plus.dart';

import '../../components/profile_card.dart';
import '../../firebase/auth_service/auth_service.dart';
import '../../utils/color_constant.dart';
import '../../utils/strings/app_string.dart';
import '../../widgets/profile_card_widget.dart';
import '../admin/notifications_screen.dart';
import '../editprofile_screen.dart';
import '../membership_screen.dart';
import '../notifications/notifications_page.dart';


class UserSetting extends StatefulWidget {
  const UserSetting({Key? key}) : super(key: key);

  @override
  State<UserSetting> createState() => _UserSettingState();
}


class _UserSettingState extends State<UserSetting> {


  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorConstants.grey,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: ColorConstants.grey,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: ColorConstants.black,
        ),
      ),
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "My Profile",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  profile_card(),
                  SizedBox(
                    height: 10.h,
                  ),
                  profile_card_widget(
                    text: "Edit Profile",
                    function: () {
                      Get.to(editprofile_screen());
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
              
                  profile_card_widget(
                    text: "Shipping Address",
                    function: () {
                      Get.to(shipping_address());
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
              
                  profile_card_widget(
                    text: "Order History",
                    function: () {
                      Get.to(order_history_screen());
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
              
                  profile_card_widget(
                    text: "Cards",
                    function: () {
                      Get.to(membership_screen());
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
              
                  profile_card_widget(
                    text: "Share",
                    function: () {
                      _onShare(context);
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  profile_card_widget(
                    text: "Notifications",
                    function: () {
                      Get.to(notifications_screen());
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
void _onShare(BuildContext context) async {
  final box = context.findRenderObject() as RenderBox;
  final Size size = MediaQuery.of(context).size;

  await Share.share(
    "The Fine Arts",
    subject: "The Fine Arts",
    // sharePositionOrigin: box.localToGlobal(Offset.infinite) & box.size
    // sharePositionOrigin: Rect.fromLTWH(0, 0,800,500)
    sharePositionOrigin: Rect.fromLTWH(0, 0, size.width, size.height / 2),
  );

}
void _onShare1(BuildContext context) {
  Share.share("The Fine Arts",
    subject: "The Fine Arts",);
}
