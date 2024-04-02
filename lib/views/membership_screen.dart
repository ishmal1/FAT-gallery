import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/membership_containers/container_column.dart';
import '../components/membership_containers/container_row.dart';
import '../utils/color_constant.dart';

class membership_screen extends StatefulWidget {
  const membership_screen({Key? key}) : super(key: key);

  @override
  State<membership_screen> createState() => _membership_screenState();
}

class _membership_screenState extends State<membership_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.grey,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Memberships",
          style: TextStyle(
            color: ColorConstants.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorConstants.grey,
        iconTheme: IconThemeData(
          color: ColorConstants.black,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15.w,right: 15.w),
        child: Column(
          children: [
            SizedBox(height: 20.h,),
            CurrentMembershipContainer(bigText: 'Simple Membership', color: [
              Colors.black,
              Colors.black
            ], smallText: 'Current Plan', height: 50.h, width: 350.w,),
            SizedBox(height: 10.h,),
            MembershipContainer(
              bigText: 'Premium Membership',
              smallText: '⦿ 2 extra months of premium when you rejoin \n⦿ Cancel anytime \n⦿ Minimum add 3 Gallery \n⦿ Many extra features',
              height: 130.h,
              width: 350.w,
              color: [
                Colors.purple,
                Colors.blue,

              ],),
            SizedBox(height: 10.h,),
            MembershipContainer(
              bigText: 'Standard Membership',
              smallText: '⦿ 2 extra months of premium when you rejoin \n⦿ Cancel anytime \n⦿ Minimum add 3 Gallery',
              height: 130.h,
              width: 350.w,
              color: [
                Colors.purple,
                Colors.blue,
              ],),
            SizedBox(height: 10.h,),
            MembershipContainer(
              bigText: 'Simple Membership',
              smallText: '⦿ 2 extra months of premium when you rejoin \n⦿ Cancel anytime   ',
              height: 130.h,
              width: 350.w,
              color: [
                Colors.purple,
                Colors.blue,
              ],),
          ],
        ),
      ),
    );
  }
}
