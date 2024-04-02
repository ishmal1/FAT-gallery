import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_signup/views/editprofile_screen.dart';
import 'package:login_signup/views/login/login_page.dart';

import '../../../utils/image_constant.dart';
import '../controller/auth_controller.dart';
import '../firebase/auth_service/auth_service.dart';
import '../utils/color_constant.dart';
import '../views/galleries_screens/approvedgalleries_screen.dart';
import '../views/map_screen/map_page.dart';
import '../views/mobile_helpsupport_screen.dart';
import '../views/products_pages/restaurant_admin.dart';

class SellerDrawer extends StatefulWidget {
  SellerDrawer({Key? key}) : super(key: key);

  @override
  State<SellerDrawer> createState() => _SellerDrawerState();
}

class _SellerDrawerState extends State<SellerDrawer> {





  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: EdgeInsets.only(left: 20.w),

      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 40.w),
                  alignment: Alignment.centerRight,
                  child: Image(image: AssetImage(ImageConstant.ellipse3)),
                ),
                SizedBox(height: 20.h,),
                Container(
                  padding: EdgeInsets.only(right: 40.w),
                  alignment: Alignment.centerRight,
                  child: Image(image: AssetImage(ImageConstant.ellipse5)),
                ),
                Container(
                  width: 120.w,
                  height: 120.h,
                  margin: EdgeInsets.only(
                    top: 18.h,
                    bottom: 10.h,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image(
                    image: AssetImage(ImageConstant.avatar),
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "Faizan Ahmed",
                  style: TextStyle(
                      color: ColorConstants.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "( faizanjutt480@gmail.com )",
                  style: TextStyle(
                    color: ColorConstants.white,
                    fontSize: 12.sp,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25.w, 0, 25.w, 0),
                  child: Divider(),
                ),
                SizedBox(
                  height: 5.h,
                ),
                ListTile(
                  onTap: () {
                    Get.to(editprofile_screen());
                  },
                  leading: Icon(Icons.account_circle_rounded,size: 25.sp),
                  title: Text('Profile',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),),
                ),
                ListTile(
                  onTap: () {
                    Get.to(const RestaurantAdmin());

                  },
                  leading: Icon(Icons.image,size: 25.sp),
                  title: Text('View Products',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),),
                ),
                ListTile(
                  onTap: () {
                    Get.to(approved_galleries());
                  },
                  leading: Icon(Icons.add,size: 25.sp),
                  title: Text('Products',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),),
                ),
                ListTile(
                  onTap: () {
                    Get.to(GoogleMaps1());
                  },
                  leading: Icon(Icons.map,size: 25.sp),
                  title: Text('Shop Location',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),),
                ),
                ListTile(
                  onTap: () {
                    Get.to(mobilehelpsupport_screen());
                  },
                  leading: Icon(Icons.settings,size: 25.sp),
                  title: Text('Help & Support',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),),
                ),
                SizedBox(
                  height: 45.h,
                ),
                Container(
                  padding: EdgeInsets.only(right: 50.w),
                  alignment: Alignment.centerRight,
                  child: Image(image: AssetImage(ImageConstant.ellipse5)),
                ),
                Container(
                  padding: EdgeInsets.only(right: 80.w),
                  alignment: Alignment.center,
                  child: Image(image: AssetImage(ImageConstant.ellipse4)),
                ),
                SizedBox(
                  height: 18.h,
                ),

      ListTile(
          onTap: (){},
          leading: Icon(Icons.logout,size: 25.sp),
          title: Text('Logout',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),),)

              ],
            ),
        ),
        ),
      );
  }
}
