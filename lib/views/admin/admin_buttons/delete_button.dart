import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/color_constant.dart';

class DeleteRestaurant extends StatelessWidget {
  final QueryDocumentSnapshot restaurants;

  const DeleteRestaurant({Key? key, required this.restaurants})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
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
                                    .update({'status': 'Deleted'});
                                Get.back();

                              },
                              child: Text("Yes",style: TextStyle(color: Colors.green),)),
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
                        title: Text('Deleting Gallery',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
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
                                style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),

                      );
                    },);



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
      icon: Icon(Icons.delete, color: Colors.red),
    );
  }
}
