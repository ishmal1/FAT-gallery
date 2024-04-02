import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_signup/utils/color_constant.dart';
import 'package:login_signup/utils/image_constant.dart';
import 'package:login_signup/views/products_pages/get_resturants.dart';
import 'package:login_signup/views/products_pages/restaurant_admin.dart';

import '../../../utils/images/images.dart';
import '../../products_pages/dishes/product_list.dart';


class getApproved_galleries extends StatelessWidget {
  final Album album;

  late bool approval;

  getApproved_galleries({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>dummy_product_list(album: this.album,)));
        // print(documentId);
      },
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        child: Container(
            padding:
            EdgeInsets.all(MediaQuery.of(context).size.height / 90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 4.2,
                  height: MediaQuery.of(context).size.height / 8.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white38,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(album.imageUrl))),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              ("Status : "),
                              style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w600),
                            ),
                            Text(
                              album.status,
                              style: TextStyle(
                                  color: album.status == "Approved"
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 10.sp,fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 250,
                        ),
                        Text(
                          album.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 12.sp,),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 160,
                        ),
                        Text(
                          album.phoneNumber,
                          style: TextStyle(fontSize: 9.sp,fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 250,
                        ),
                        Text(
                          album.email,
                          style: TextStyle(fontSize: 9.sp,fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 250,
                        ),
                        Text(
                          album.address,
                          style: TextStyle(fontSize: 9.sp,fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width / 9,
                  child: IconButton(
                      onPressed: () {
                        showDialog(context: context, builder: (BuildContext context) {
                          return  AlertDialog(
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            contentPadding: EdgeInsets.only(left: 18.w,right: 18.w),
                            actions: [
                              TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: ColorConstants.purple,
                                  ),
                                  onPressed: (){
                                    // FirebaseFirestore.instance
                                    //     .collection("Restaurants")
                                    //     .doc(documentId)
                                    //     .delete();

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
                            title: Text('Deleting Restaurant',
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
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: MediaQuery.of(context).size.width / 19,
                      )),
                ),
              ],
            )),
      ),
    );
  }
}
