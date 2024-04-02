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


class getWaiting_galleries extends StatelessWidget {
  final Album album;

  late bool approval;

  getWaiting_galleries({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> dummy_product_list(album: this.album,)));
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
                          image: NetworkImage(album.imageUrl))
                  ),
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
                                  color: album.status == "Waiting"
                                      ? Colors.red
                                      : Colors.green,
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
