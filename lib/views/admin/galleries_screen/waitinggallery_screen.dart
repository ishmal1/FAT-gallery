import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login_signup/views/admin/galleries_screen/components/approved_tab.dart';
import 'package:login_signup/views/admin/galleries_screen/components/waiting_tab.dart';
import '../../../components/drawer_view.dart';
import '../../../firebase/auth_service/auth_service.dart';
import '../galleries_screen/waitinggallery_screen.dart';

import '../../../utils/color_constant.dart';
import '../../../utils/image_constant.dart';
import 'approvedgallery_screen.dart';
import 'blockedgallery_screen.dart';
import '../../../components/drawer_view.dart';
import '../../../controller/auth_controller.dart';
import '../help&support_screen.dart';
import '../login_page/admin_login.dart';
import '../admin_home_screen/adminhome_screen.dart';
import '../notifications_screen.dart';
import 'approvedgallery_screen.dart';
import 'components/blocked_tab.dart';
import 'components/getwaitinggallery_screen.dart';


class gallerylist_screen extends StatefulWidget {
  const gallerylist_screen({Key? key}) : super(key: key);

  @override
  State<gallerylist_screen> createState() => _gallerylist_screenState();
}

class _gallerylist_screenState extends State<gallerylist_screen> {

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey();

    CollectionReference restaurants =
    FirebaseFirestore.instance.collection("Restaurants");
    final Stream<QuerySnapshot> snapshot = FirebaseFirestore.instance
        .collection("Restaurants")
        .snapshots(includeMetadataChanges: true);
    return Scaffold(
      drawer: Drawer(child: DrawerView()),
      key: _key,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorConstants.grey,
        automaticallyImplyLeading: true,
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.more_vert),
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context){
                return [
                  PopupMenuItem<int>(
                      value: 0,
                      child: TextButton.icon(
                          onPressed: (){
                            Get.to(adminhome_screen());
                          }, icon: Icon(Icons.home), label: Text("Dashboard",style: TextStyle(color: Colors.black),))),
                  PopupMenuItem<int>(
                      value: 1,
                      child: TextButton.icon(
                          onPressed: (){
                            // Get.to(notifications_screen());
                          }, icon: Icon(Icons.notifications_active), label: Text("Notifications",style: TextStyle(color: Colors.black),))),

                  PopupMenuItem<int>(
                      value: 2,
                      child: TextButton.icon(
                          onPressed: (){
                            Get.to(helpsupport_screen());
                          }, icon: Icon(Icons.help), label: Text("Help & Support",style: TextStyle(color: Colors.black),))),

                  PopupMenuItem<int>(
                      value: 3,
                      child: TextButton.icon(
                          onPressed: (){
                            Timer(const Duration(seconds: 4), () {
                              AuthController().showLoaderDialog(context, "signing out");
                            });
                            FirebaseAuth auth = FirebaseAuth.instance;
                            auth.signOut();
                            Get.offAll(const adminlogin_screen());
                          }, icon: Icon(Icons.logout), label: Text("Logout",style: TextStyle(color: Colors.black),))),
                ];
              },
              onSelected:(value){
                if(value == 0){
                  print("My account menu is selected.");
                }else if(value == 1){
                  print("Settings menu is selected.");
                }else if(value == 2) {
                  print("Logout menu is selected.");
                }else if(value == 3){
                  print("Logout menu is selected.");
                }
              }
          ),
        ],

        iconTheme: IconThemeData(
          color: ColorConstants.black,
        ),
      ),
      backgroundColor: ColorConstants.grey,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      ImageConstant.adminBack,
                    ),
                    fit: BoxFit.cover)),
          ),
          Center(
            child: SizedBox(
                height: 600.h,
                width: 320.w,
                child: Card(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding:
                          EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 5.sp,
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.transparent,
                                backgroundImage:  AssetImage(ImageConstant.avatar),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              SizedBox(
                                  width: 50.w,
                                  child: Text(
                                    "Tayyab",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 4.sp,
                                        overflow: TextOverflow.ellipsis),
                                  )),
                              SizedBox(
                                width: 210.w,
                              ),
                              Text(
                                "Contact Us",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 4.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),

                        SizedBox(
                            width: 320.w,
                            child: Divider(
                              color: Colors.black,
                              thickness: 2,
                            )),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Get.to(gallerylist_screen());
                              },
                              child: waiting_tab(),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.to(galleryapproved_screen());
                              },
                              child: approved_tab(),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.to(galleryblocked_screen());
                              },
                              child: bloack_tab(),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        DefaultTextStyle(
                          style: TextStyle(
                              fontSize: 5.5.sp,color: Colors.black,fontWeight: FontWeight.w600
                          ),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              WavyAnimatedText('Waiting Gallery',),
                            ],
                            isRepeatingAnimation: false,
                            onTap: () {
                              print("Tap Event");
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        // Expanded(
                        //     child: FutureBuilder(
                        //         builder: (context, snapshot) {
                        //           return
                        //         }))
                        Padding(
                          padding: EdgeInsets.only(
                            left: 30.w,
                            right: 30.w,
                          ),
                          child: StreamBuilder(
                            stream: restaurants
                                .where('status', isEqualTo: 'Pending')
                                .snapshots(),
                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Center(child: CircularProgressIndicator()),
                                    SizedBox(height: 10.h,),
                                    Center(child: Text("No Data"))
                                  ],
                                );
                              }
                              if (snapshot.hasError) {
                                return const Center(
                                  child: Text('Snapshot error'),
                                );
                              }
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: Text('Snapshot data missing'),
                                );
                              }
                              return GridView(
                                shrinkWrap: true,
                                padding: EdgeInsets.only(bottom: 5.h),
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 6,
                                    mainAxisSpacing: 2.h,
                                    mainAxisExtent: 270.h,
                                    crossAxisSpacing: 5.h,
                                    childAspectRatio: 4 / 4),
                                children: snapshot.data!.docs.map((restaurants) {
                                  return getWaitingList_screen(
                                    restaurants: restaurants,
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          )

        ],
      ),
    );
  }
}

