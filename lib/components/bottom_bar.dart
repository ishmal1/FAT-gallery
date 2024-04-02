import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/color_constant.dart';
import '../views/checkout_screen.dart';
import '../views/favourite_item_screen.dart';
import '../views/home_screen/buyer_home_screen.dart';
import '../views/map_screen/maps.dart';
import '../views/user_setting/user_setting.dart';


// ignore: camel_case_types, use_key_in_widget_constructors
class Bottom_Bar extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _Bottom_BarState createState() => _Bottom_BarState();
}

// ignore: camel_case_types
class _Bottom_BarState extends State<Bottom_Bar> {
  int _currentIndex = 0;

  List list = <Widget>[
    home_screen(),
    favourite_item_screen(),
    UserSetting(),
    checkout_screen(checkoutItems: [],),
    GoogleMaps(),

  ];

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      backgroundColor: ColorConstants.grey,
      selectedIndex: _currentIndex,
      showElevation: false,
      itemCornerRadius: 20.r,
      curve: Curves.easeIn,
      onItemSelected: (index) {
        setState(() => _currentIndex = index);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => list[index]));
        // change selected index when push back to home page // _currentIndex = 0;
        // _currentIndex = 0;
      },
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          // ignore: prefer_const_constructors
          icon: Icon(
            Icons.home_outlined,
            size: 22.sp,
          ),
          title: Text('Home',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w600),),
          activeColor: ColorConstants.purple,
          textAlign: TextAlign.center,
          inactiveColor: ColorConstants.iconcolor,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.favorite_border_outlined,size: 22.sp,),
          title: Text('Favourite',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w600),),
          activeColor: ColorConstants.purple,
          textAlign: TextAlign.center,
          inactiveColor: ColorConstants.iconcolor,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.person_outlined,size: 22.sp,),
          title: Text(
            'Profile',
            style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w600),
          ),
          inactiveColor: ColorConstants.iconcolor,
          activeColor: ColorConstants.purple,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.shopping_cart_outlined,size: 22.sp,),
          title: Text('Checkout',style: TextStyle(fontSize: 8.sp),),
          activeColor: ColorConstants.purple,
          inactiveColor: ColorConstants.iconcolor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.map,size: 22.sp,),
          title: Text(
            'Map',
            style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w600),
          ),
          inactiveColor: ColorConstants.iconcolor,
          activeColor: ColorConstants.purple,
          textAlign: TextAlign.center,
        ),

      ],
    );
  }
}
