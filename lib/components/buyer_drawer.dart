import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:full_screen_image/full_screen_image.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_signup/firebase/firestore_fetch_data/fetch_user_data.dart';
import 'package:login_signup/views/cards_screen.dart';
import 'package:login_signup/views/login/login_page.dart';


import '../../../utils/image_constant.dart';

import '../controller/auth_controller.dart';
import '../firebase/auth_service/auth_service.dart';
import '../shipping_address.dart';
import '../utils/color_constant.dart';
import '../views/editprofile_screen.dart';
import '../views/order_history.dart';
import '../views/suggestion_screen.dart';
import 'module_switch_dialog.dart';

class Buyer_Drawer extends StatefulWidget {
  const Buyer_Drawer({Key? key}) : super(key: key);

  @override
  State<Buyer_Drawer> createState() => _Buyer_DrawerState();
}

class _Buyer_DrawerState extends State<Buyer_Drawer> {



  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      textColor: Colors.white,
      iconColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: 20.w),
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
                  top: 20.h,
                  bottom: 20.h,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: FullScreenWidget(
                  disposeLevel: DisposeLevel.Low,
                  child: Image(
                    image: AssetImage(ImageConstant.avatar),
                    fit: BoxFit.cover,
                  ),
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
                height: 20.h,
              ),
              // Container(
              //   padding: EdgeInsets.only(right: 110.w),
              //   child: FlutterSwitch(
              //     duration: Duration(milliseconds: 1000),
              //     width: 120.0.w,
              //     height: 35.0.h,
              //     valueFontSize: 13.0.sp,
              //     toggleSize: 40.0,
              //     value: tenant,
              //     borderRadius: 25.0,
              //     activeColor: Colors.black,
              //     inactiveIcon: Icon(Icons.manage_accounts_rounded,color: Colors.black,size: 18.sp,),
              //     activeIcon: Icon(Icons.person,color: Colors.black,size: 18.sp,),
              //     showOnOff: true,
              //     padding: 6.0.w,
              //     inactiveTextColor: Colors.black,
              //     activeTextColor: Colors.white,
              //     activeText: "Seller",
              //     inactiveText: "Buyer",
              //     onToggle: (value) {
              //       showDialog(
              //         context: context,
              //         builder: (BuildContext context) {
              //           return ModuleSwitchDialog();
              //         },
              //       );
              //       // if(tenant == true){
              //       //   tenant = false;
              //       //   Navigator.push(context, MaterialPageRoute(builder: (context)=> OwnerMainPage()));
              //       //
              //       // }else{
              //       //   tenant = true;
              //       //   Navigator.push(context, MaterialPageRoute(builder: (context)=> MainPage()));
              //       // }
              //       // print(tenant);
              //
              //     },
              //   ),),

              ListTile(
                onTap: () {
                  Get.to( editprofile_screen());
                },
                leading: Icon(Icons.account_circle_rounded,size: 25.sp,),
                title: Text('Profile',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),),
              ),
              ListTile(
                onTap: () {
                  Get.to( shipping_address());
                },
                leading: Icon(Icons.local_shipping,size: 25.sp),
                title: Text('Edit Shipping Details',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),),
              ),
              ListTile(
                onTap: () {
                  Get.to(const cards_screen());
                },
                leading: Icon(Icons.payment,size: 25.sp),
                title: Text('Manage Payment',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),),
              ),
              ListTile(
                onTap: () {
                  Get.to(SearchResultsPage());
                },
                leading: Icon(Icons.youtube_searched_for,size: 25.sp),
                title: Text('Recommended Posts',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),),
              ),
              ListTile(
                onTap: () {
                  Get.to(order_history_screen());
                },
                leading: Icon(Icons.shopping_basket,size: 25.sp),
                title: Text('Ordered Products',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),),
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
          leading: Icon(Icons.logout,size: 25.sp,),
          title:  Text('Logout',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),),
      ),
            ],
          ),
        ),
      ),
    );
  }
}
