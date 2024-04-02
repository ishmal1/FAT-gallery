import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/image_constant.dart';
import '../../../../utils/images/images.dart';
import '../../admin_buttons/approve_reject_buttons.dart';
import '../../admin_buttons/delete_button.dart';

class getWaitingList_screen extends StatelessWidget {
  final QueryDocumentSnapshot restaurants;
  const getWaitingList_screen({Key? key, required this.restaurants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = restaurants?.data();
    final imageUrl = data is Map && data.containsKey('image_url') ? data['image_url'] : '';
    return Card(
      child: Column(
        children: [
          restaurants['image_url'] == null || restaurants['image_url'].isEmpty ? Container(
            width: 35.w,
            height: 80.h,
            margin: EdgeInsets.all(MediaQuery.of(context).size.width / 200),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white38,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(ImageConstant.watch,))),
          ) : Container(
            width: 35.w,
            height: 80.h,
            margin: EdgeInsets.all(MediaQuery.of(context).size.width / 200),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white38,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(imageUrl))),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 200,),
          Text(restaurants['restaurantName'], style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12),),
          SizedBox(height: MediaQuery.of(context).size.height / 120,),
          Text(restaurants['phoneNumber'],style: TextStyle(fontSize: 11),),
          SizedBox(height: MediaQuery.of(context).size.height / 250,),
          Text(restaurants['email'],style: TextStyle(fontSize: 11),),
          SizedBox(height: MediaQuery.of(context).size.height / 250,),
          Text(restaurants['address'],style: TextStyle(fontSize: 11),),
          restaurants['status'] == 'Pending'
              ? RestaurantButtons(
            restaurants: this.restaurants,
          )
              : DeleteRestaurant(
            restaurants: this.restaurants,
          )
        ],

      ),
    );
  }
}
