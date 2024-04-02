import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../../../../utils/image_constant.dart';
import '../../../../utils/color_constant.dart';


class getUserList_screen extends StatelessWidget {
  final QueryDocumentSnapshot users;
  const getUserList_screen({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = users?.data();
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
      endActionPane: users['status'] == 'Approved' ? ActionPane(
        extentRatio: 0.2,
        motion: const DrawerMotion(), children: [
        SlidableAction(
          onPressed: (context){
            showDialog(context: context, builder: (BuildContext context) {
              return AlertDialog(
                surfaceTintColor: Colors.white,
                backgroundColor: Colors.white,
                contentPadding: EdgeInsets.only(left: 18.w,right: 18.w),
                actions: [
                  TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: ColorConstants.purple,
                      ),
                      onPressed: (){
                        FirebaseFirestore.instance.collection("Users").doc(users.reference.id).update({'status': 'Deleted'});
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
                title: Text('Deleting Account',
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
                surfaceTintColor: Colors.white,
                backgroundColor: Colors.white,
                contentPadding: EdgeInsets.only(left: 18.w,right: 18.w),
                actions: [
                  TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: ColorConstants.purple,
                      ),
                      onPressed: (){
                        FirebaseFirestore.instance
                            .collection("Users")
                            .doc(users.reference.id)
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
                title: Text('Blocking Account',
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
        )

      ],) : ActionPane(
        extentRatio: 0.1,
        motion: const DrawerMotion(), children: [
        SlidableAction(

          onPressed: (context){
            showDialog(context: context, builder: (BuildContext context) {
              return AlertDialog(
                surfaceTintColor: Colors.white,
                backgroundColor: Colors.white,
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
                            .doc(users.reference.id)
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
                title: Text('Unblocking Account',
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
          surfaceTintColor: Colors.transparent,
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
                  users['image'] == null || users['image'].isEmpty ? CircleAvatar(
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
                          child: Text(users["displayName"],style: TextStyle(color: Colors.black,fontSize: 5.sp,fontWeight: FontWeight.w700,overflow: TextOverflow.ellipsis),)),
                      SizedBox(height: 5.h,),
                      SizedBox(
                          width: 100.w,
                          child: Text(users["email"],style: TextStyle(color: Colors.black54,fontSize: 4.sp,overflow: TextOverflow.ellipsis))),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 130.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Role:",style: TextStyle(color: Colors.black,fontSize: 5.sp,fontWeight: FontWeight.w700,overflow: TextOverflow.ellipsis),),
                            SizedBox(width: 1.w,),
                            SizedBox(
                                width: 30.w,
                                child: Text(users["role"],style: TextStyle(color: Colors.black54,fontSize: 5.sp,fontWeight: FontWeight.normal,overflow: TextOverflow.ellipsis),)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // actions: <Widget>[
      //   IconSlideAction(
      //     caption: 'Archive',
      //     color: Colors.blue,
      //     icon: Icons.archive,
      //     onTap: () {
      //       // Perform archive action
      //       // You can put your own logic here
      //       print('Archived $item');
      //     },
      //   ),
      // ],
      // secondaryActions: <Widget>[
      //   IconSlideAction(
      //     caption: 'Delete',
      //     color: Colors.red,
      //     icon: Icons.delete,
      //     onTap: () {
      //       // Perform delete action
      //       // You can put your own logic here
      //       setState(() {
      //         items.removeAt(index);
      //       });
      //       print('Deleted $item');
      //     },
      //   ),
      // ],
    );
  }
}
