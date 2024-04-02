// import 'dart:async';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:login_signup/views/admin/admin_home_screen/adminhome_screen.dart';
//
// import '../../components/drawer_view.dart';
// import '../../constants/big_text.dart';
// import '../../controller/auth_controller.dart';
// import '../../utils/color_constant.dart';
// import '../../utils/image_constant.dart';
// import '../../utils/images/images.dart';
// import 'help&support_screen.dart';
// import 'login_page/admin_login.dart';
//
//
//
// class notifications_screen extends StatefulWidget {
//   const notifications_screen({Key? key}) : super(key: key);
//
//   @override
//   State<notifications_screen> createState() => _NotificationPageState();
// }
//
// class _NotificationPageState extends State<notifications_screen> {
//   @override
//   Widget build(BuildContext context) {
//     final GlobalKey<ScaffoldState> _key = GlobalKey();
//
//     return Scaffold(
//         drawer: Drawer(child: DrawerView()),
//         key: _key,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: ColorConstants.grey,
//           automaticallyImplyLeading: true,
//           actions: [
//             PopupMenuButton(
//                 icon: Icon(Icons.more_vert),
//                 // add icon, by default "3 dot" icon
//                 // icon: Icon(Icons.book)
//                 itemBuilder: (context){
//                   return [
//                     PopupMenuItem<int>(
//                         value: 0,
//                         child: TextButton.icon(
//                             onPressed: (){
//                               Get.to(adminhome_screen());
//                             }, icon: Icon(Icons.home), label: Text("Dashboard",style: TextStyle(color: Colors.black),))),
//
//                     PopupMenuItem<int>(
//                         value: 1,
//                         child: TextButton.icon(
//                             onPressed: (){
//                               Get.to(helpsupport_screen());
//                             }, icon: Icon(Icons.help), label: Text("Help & Support",style: TextStyle(color: Colors.black),))),
//
//                     PopupMenuItem<int>(
//                         value: 2,
//                         child: TextButton.icon(
//                             onPressed: (){
//                               Timer(const Duration(seconds: 4), () {
//                                 AuthController().showLoaderDialog(context, "signing out");
//                               });
//                               FirebaseAuth auth = FirebaseAuth.instance;
//                               auth.signOut();
//                               Get.offAll(const adminlogin_screen());
//                             }, icon: Icon(Icons.logout), label: Text("Logout",style: TextStyle(color: Colors.black),))),
//                   ];
//                 },
//                 onSelected:(value){
//                   if(value == 0){
//                     print("My account menu is selected.");
//                   }else if(value == 1){
//                     print("Settings menu is selected.");
//                   }else if(value == 2) {
//                     print("Logout menu is selected.");
//                   }else if(value == 3){
//                     print("Logout menu is selected.");
//                   }
//                 }
//             ),
//           ],
//           iconTheme: IconThemeData(
//             color: ColorConstants.black,
//           ),
//         ),
//         backgroundColor: ColorConstants.grey,
//         body: Stack(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage(
//                         ImageConstant.adminBack,
//                       ),
//                       fit: BoxFit.cover)),
//             ),
//             Center(
//               child: SizedBox(
//                 height: 600.h,
//                 width: 320.w,
//                 child: Card(
//                   color: Colors.white,
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 15.w,right: 15.w),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         //Icons and Text
//                         SizedBox( height: 20.h,),
//                         BigText(
//                           size: 7.sp,
//                           fontWeight: FontWeight.w700, text: "Today",),
//                         SizedBox( height: 5.h,),
//
//                         //TExtField
//                         Card(
//                           color: Colors.white,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10,),),
//                           child: Container(
//                             height: 65.h,
//                             width: 400.w,
//                             child: Row(
//                               // crossAxisAlignment: CrossAxisAlignment.start,
//                               // mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 SizedBox(width: 2.h,),
//                                 Image(
//                                     image: AssetImage(AppImages.congrats1,)),
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text("Order Successful !",style: TextStyle(color: Colors.black,fontSize: 6.sp,fontWeight: FontWeight.w700)),
//                                     SizedBox(height: 5.h,),
//                                     Text("You received your order soon",style: TextStyle(color: Colors.black54,fontSize: 4.sp)),
//
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox( height: 5.h,),
//                         Card(
//                           color: Colors.white,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10,),),
//                           child: Container(
//                             height: 65.h,
//                             width: 400.w,
//                             child: Row(
//                               children: [
//                                 Image(
//                                     image: AssetImage(AppImages.reject,)),
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text("Order Cancelled",style: TextStyle(color: Colors.black,fontSize: 6.sp,fontWeight: FontWeight.w700)),
//                                     SizedBox(height: 5.h,),
//                                     Text("Dew to out of stock",style: TextStyle(color: Colors.black54,fontSize: 4.sp)),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         //Button
//
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//
//           ],
//         ));
//   }
// }
