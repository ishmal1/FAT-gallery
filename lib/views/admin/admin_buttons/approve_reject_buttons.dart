import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/color_constant.dart';

class RestaurantButtons extends StatelessWidget {
  final QueryDocumentSnapshot restaurants;
  const RestaurantButtons({Key? key, required this.restaurants})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              showDialog(context: context, builder: (BuildContext context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.only(left: 18.w,right: 18.w),
                  actions: [
                    TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: ColorConstants.purple,
                        ),
                        onPressed: (){
                          FirebaseFirestore.instance
                              .collection("Restaurants")
                              .doc(restaurants.reference.id)
                              .update({'status': 'Approved'});
                          Get.back();


                        },
                        child: Text("Yes",style: TextStyle(color: Colors.green,),)),
                    TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: ColorConstants.purple,
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("No",style: TextStyle(color: Colors.red),)),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  title: Text('Approving Gallery',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 6.sp),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image(
                          height: 120.h,
                          fit: BoxFit.cover,
                          image: const AssetImage('assets/images/listening.gif',)),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Are you sure you want to continue?',
                          style: TextStyle(fontSize: 4.sp,fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),

                );
              },);

              // GetRestaurants();

            },
            icon: Icon(
              Icons.check,
              color: Colors.green,
            )),
        IconButton(
            onPressed: () {
              showDialog(context: context, builder: (BuildContext context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.only(left: 18.w,right: 18.w),
                  actions: [
                    TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: ColorConstants.purple,
                        ),
                        onPressed: (){
                          FirebaseFirestore.instance
                              .collection("Restaurants")
                              .doc(restaurants.reference.id)
                              .update({'status': 'Blocked'});
                          Get.back();


                        },
                        child: Text("Yes",style: TextStyle(color: Colors.green,),)),
                    TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: ColorConstants.purple,
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("No",style: TextStyle(color: Colors.red),)),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  title: Text('Rejecting Gallery',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 6.sp),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image(
                          height: 120.h,
                          fit: BoxFit.cover,
                          image: const AssetImage('assets/images/listening.gif',)),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Are you sure you want to continue?',
                          style: TextStyle(fontSize: 4.sp,fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),

                );
              },);


            },
            icon: Icon(
              Icons.close,
              color: Colors.red,
            )),
      ],
    );
  }
}