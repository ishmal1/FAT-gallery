import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login_signup/utils/image_constant.dart';
import 'package:login_signup/views/admin/admin_profile_screen.dart';
import 'package:login_signup/views/admin/adminlist_screen/approvedadminlist_screen.dart';
import 'package:login_signup/views/admin/userlist_screen/approveduserlist_screen.dart';
import 'package:login_signup/views/galleries_screens/waitinggallerieslist_screen.dart';

import '../constants/big_text.dart';
import '../firebase/auth_service/auth_service.dart';
import '../utils/color_constant.dart';
import '../views/admin/galleries_screen/waitinggallery_screen.dart';
import 'module_switch_dialog.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {

  int value = 0;
  bool positive = false;
  bool loading = false;
  @override
  Widget build(BuildContext context) {

    return ListView(
      primary: true,
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                // color: Color.fromRGBO(10, 205, 70, 10),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xff5956E9),
                    Color(0xff58C0EA),
                  ],
                  transform: GradientRotation(125),
                ),
              ),
              accountName: Padding(
                padding: EdgeInsets.only(left: 3.w),
                child: Text("Tayyab",style: TextStyle(
                  fontWeight: FontWeight.w600,

                ),
                  // textColor: Colors.white,
                  // fontSize: 13.sp,fontWeight: FontWeight.bold,
                ),),
              accountEmail: Padding(
                padding: EdgeInsets.only(left: 3.w),
                child: Text(
                  "tayyabwaseem24@gmail.com",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    // fontSize: 13.sp,
                    // textColor: Colors.white,
                ),
              ),
              currentAccountPicture: GestureDetector(
                onTap: () {
                  //Bottom Sheet
                  // showModalBottomSheet(
                  //     context: context,
                  //     builder: (context) {
                  //       return Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: <Widget>[
                  //           ListTile(
                  //             leading: const Icon(Icons.delete),
                  //             title: const StandardText(text:'Delete Photo'),
                  //             onTap: () {
                  //               Navigator.pop(context);
                  //             },
                  //           ),
                  //           ListTile(
                  //             leading: const Icon(Icons.camera_alt),
                  //             title: const StandardText(text: 'Capture From Camera'),
                  //             onTap: () {
                  //
                  //             },
                  //           ),
                  //           ListTile(
                  //             leading: const Icon(Icons.photo),
                  //             title: const StandardText(text: 'Choose From Gallery'),
                  //             onTap: () {
                  //
                  //             },
                  //           ),
                  //         ],
                  //       );
                  //     });
                },

                child: Padding(
                  padding: EdgeInsets.only(left: 3.w),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(ImageConstant.avatar),
                  ),
                ),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.only(right: 120.w),
            //     child: FlutterSwitch(
            //       duration: Duration(milliseconds: 1000),
            //       width: 120.0.w,
            //       height: 35.0.h,
            //       valueFontSize: 11.0.sp,
            //       toggleSize: 40.0,
            //       value: tenant,
            //       borderRadius: 5.0,
            //       activeColor: Colors.black,
            //       inactiveIcon: Icon(Icons.manage_accounts_rounded,color: Colors.black,size: 18.sp,),
            //       activeIcon: Icon(Icons.person,color: Colors.black,size: 18.sp,),
            //       showOnOff: true,
            //       padding: 6.0.w,
            //       inactiveTextColor: Colors.black,
            //       activeTextColor: Colors.white,
            //       activeText: "Tenant",
            //       inactiveText: "Admin",
            //       onToggle: (value) {
            //         setState(() {
            //           showDialog(
            //             context: context,
            //             builder: (BuildContext context) {
            //               return ModuleSwitchDialog();
            //             },
            //           );
            //           // if(tenant == true){
            //           //   tenant = false;
            //           //   Navigator.push(context, MaterialPageRoute(builder: (context)=> OwnerMainPage()));
            //           //
            //           // }else{
            //           //   tenant = true;
            //           //   Navigator.push(context, MaterialPageRoute(builder: (context)=> MainPage()));
            //           // }
            //           // print(tenant);
            //         });
            //       },
            //     ),),
            // Padding(
            //   padding: EdgeInsets.only(left: 15.w,right: 100.w),
            //   child: AnimatedToggleSwitch<bool>.dual(
            //     current: tenant,
            //     borderRadius: BorderRadius.zero,
            //     first: false,
            //     second: true,
            //     borderColor: Colors.white,
            //     borderWidth: 5.0,
            //     height: 40.h,
            //     boxShadow: const [
            //       BoxShadow(
            //         color: Colors.black45,
            //         spreadRadius: 1,
            //         blurRadius: 2,
            //         offset: Offset(0, 1.5),
            //       ),
            //     ],
            //     onChanged: (value) {
            //       setState(() {
            //         if(tenant == true){
            //           tenant = false;
            //           Navigator.push(context, MaterialPageRoute(builder: (context)=> OwnerMainPage()));
            //
            //         }else{
            //           tenant = true;
            //           Navigator.push(context, MaterialPageRoute(builder: (context)=> MainPage()));
            //
            //         }
            //         print(tenant);
            //       });
            //       return Future.delayed(Duration(seconds: 10));
            //
            //     },
            //     colorBuilder: (tenant) => tenant == false ? Colors.red : color_green,
            //     iconBuilder: (tenant) => tenant == false
            //         ? Icon(Icons.manage_accounts_rounded)
            //         : Icon(Icons.person),
            //     textBuilder: (tenant) => tenant == false
            //         ? Center(child: Text('Admin',style: TextStyle(fontWeight: FontWeight.bold),))
            //         : Center(child: Text('Tenant',style: TextStyle(fontWeight: FontWeight.bold,))),
            //   ),
            // ),
              ListTile(
              minLeadingWidth: 1.w,
              leading: Icon(
                Icons.settings,
                  color: Colors.grey
              ),
              title: Text('Profile',),
              onTap: () {
                Get.to(admin_profile_screen());
                // Navigator.of(context).pushNamed(
                //     AppRoutes.UserSetting);
              },
            ),
            ListTile(
              minLeadingWidth: 1.w,
              leading: Icon(
                Icons.admin_panel_settings,
                  color: Colors.grey
              ),
              title: Text('Admins List',),
              onTap: () {
                Get.to(approvedadminlist_screen());

                // Navigator.of(context).pushNamed(
                //     AppRoutes.Notification);
              },
            ),
            ListTile(
              minLeadingWidth: 1.w,
              leading: Icon(
                Icons.browse_gallery,
                  color: Colors.grey
              ),
              title: Text('Galleries List',),
              onTap: () {
                Get.to(gallerylist_screen());

              },
            ),
            ListTile(
              minLeadingWidth: 1.w,
              leading: Icon(
                Icons.verified_user,
                  color: Colors.grey
              ),
              title: Text('Users List',),
              onTap: () {
                Get.to(approveduserlist_screen());

              },
            ),

          ],
        );
  }
}
