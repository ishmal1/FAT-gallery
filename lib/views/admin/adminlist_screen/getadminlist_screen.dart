import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/image_constant.dart';
import '../../../utils/color_constant.dart';


class getAdminList_screen extends StatelessWidget {
  final QueryDocumentSnapshot admin;
  const getAdminList_screen({Key? key, required this.admin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = admin?.data();
    final imageUrl = data is Map && data.containsKey('image') ? data['image'] : '';


    return Slidable(
      closeOnScroll: true,
      startActionPane: ActionPane(
        extentRatio: 0.1,
        motion: const DrawerMotion(),
        dragDismissible: true,
        children: [
          SlidableAction(
            onPressed: (context){},
            icon: Icons.edit,
            backgroundColor: Colors.blue,
            label: "Edit",
            borderRadius: BorderRadius.circular(5),
            autoClose: true,

          )
        ],),
      endActionPane: admin['status'] == 'Approved' && admin['role'] == 'Admin' ?
      ActionPane(
        extentRatio: 0.2,
        motion: const DrawerMotion(), children: [
        SlidableAction(
          onPressed: (context){
            showDialog(context: context, builder: (BuildContext context) {
              return AlertDialog(
                contentPadding: EdgeInsets.only(left: 18.w,right: 18.w),
                actions: [
                  TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: ColorConstants.purple,
                      ),
                      onPressed: (){
                        FirebaseFirestore.instance.collection("Users").doc(admin.reference.id).update({'status': 'Deleted'});
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
                title: Text('Deleting Admin',
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
          icon: Icons.delete,
          backgroundColor: Colors.red,
          label: "Delete",
          borderRadius: BorderRadius.circular(5),
          autoClose: true,
        ),
        SlidableAction(
          onPressed: (context){
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
                            .collection("Users")
                            .doc(admin.reference.id)
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
                title: Text('Blocking Admin',
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
          icon: Icons.block,
          backgroundColor: Colors.black,
          label: "Block",
          borderRadius: BorderRadius.circular(5),
          autoClose: true,
        ),

      ],) : ActionPane(
    extentRatio: 0.1,
    motion: const DrawerMotion(), children: [
        SlidableAction(
          onPressed: (context){
            showDialog(context: context, builder: (BuildContext context) {
              return AlertDialog(
                contentPadding: EdgeInsets.only(left: 18.w,right: 18.w),
                actions: [
                  TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: ColorConstants.purple,
                      ),
                      onPressed: (){
                        Get.back();
                        FirebaseFirestore.instance
                            .collection("Users")
                            .doc(admin.reference.id)
                            .update({'status': 'Approved'});

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
                title: Text('Unblocking Admin',
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
          icon: Icons.block,
          backgroundColor: Colors.green,
          label: "Unblock",
          borderRadius: BorderRadius.circular(5),
          autoClose: true,
        )

      ],),
      child: Center(
        child: Card(
          color: Colors.grey[100],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5,),),
          child: SizedBox(
            height: 65.h,
            width: 300.w,
            child: Padding(
              padding: EdgeInsets.only(left: 2.w,right: 2.w),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // admin['image'] == null || admin['image'].isEmpty
                  //     ? Image(
                  //   height: 50.h,
                  //   image: AssetImage(ImageConstant.avatar),
                  // )
                  //     : Image(
                  //   height: 50.h,
                  //   image: CachedNetworkImageProvider(imageUrl),
                  // ),
                  admin['image'] == null || admin['image'].isEmpty ? CircleAvatar(
                    radius: 9.sp,
                    backgroundImage: AssetImage(ImageConstant.avatar),
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.transparent,
                  ) : CircleAvatar(
                    radius: 9.sp,
                    backgroundImage: CachedNetworkImageProvider(imageUrl),
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.transparent,
                  ),
                  SizedBox(width: 5.h,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 80.w,
                          child: Text(admin["displayName"],style: TextStyle(color: Colors.black,fontSize: 5.sp,fontWeight: FontWeight.w700,overflow: TextOverflow.ellipsis),)),
                      SizedBox(height: 5.h,),
                      SizedBox(
                          width: 100.w,
                          child: Text(admin["email"],style: TextStyle(color: Colors.black54,fontSize: 4.sp,overflow: TextOverflow.ellipsis))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
