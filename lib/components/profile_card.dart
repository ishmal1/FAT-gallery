import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';

import '../../../../utils/image_constant.dart';
import '../firebase/auth_service/auth_service.dart';

// ignore: use_key_in_widget_constructors, camel_case_types
class profile_card extends StatefulWidget {
  const profile_card({Key? key}) : super(key: key);

  @override
  State<profile_card> createState() => _profile_cardState();
}

class _profile_cardState extends State<profile_card> {
  final double circleRadius = 90.r;
  final double circleBorderWidth = 1.w;


  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> dummyProfileData = [
      {
        'name': 'John Doe',
        'address': '123 Main St, City, Country',
      },
      // Add more dummy data as needed
    ];
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
    ListView.builder(
    itemCount: dummyProfileData.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final profileData = dummyProfileData[index];

        return Padding(
          padding: EdgeInsets.only(top: circleRadius / 2.0),
          child: Container(
            color: Colors.transparent,
            width: Get.width,
            child: Card(
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 35.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 13.w),
                      child: Center(
                        child: Text(
                          profileData['name'],
                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image(image: AssetImage(ImageConstant.gps)),
                        SizedBox(
                          width: 18.w,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 17.h),
                          child: Text(
                            profileData['address'],
                            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
    FullScreenWidget(
          disposeLevel: DisposeLevel.Low,
          child: Container(
            width: circleRadius,
            height: circleRadius,
            decoration: const ShapeDecoration(
                shape: CircleBorder(), color: Colors.transparent),
            child: Padding(
              padding: EdgeInsets.all(circleBorderWidth),
              child: DecoratedBox(
                decoration: ShapeDecoration(
                    shape: const CircleBorder(),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(ImageConstant.avatar)
                    )),
              ),
            ),
          ),
        )
      ],
    );
  }
}
