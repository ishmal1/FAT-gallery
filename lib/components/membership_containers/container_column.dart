import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/big_text.dart';
import '../../constants/small_text.dart';


class MembershipContainer extends StatelessWidget {
  List<Color> color =[];
  final String bigText;
  final String smallText;
  final double height;
  final double width;
  MembershipContainer({Key? key,
    required this.bigText,
    required this.color,
    required this.smallText, required this.height, required this.width,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: color,
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [0.3, 0.7],
          tileMode: TileMode.repeated,
        ),

      ),
      child: Column(
        children: [
          SizedBox(height: 30.h,),
          BigText(text: bigText,color: Colors.white,size: 14.sp,),
          SizedBox(height: 5.h,),
          SmallText(text: smallText,color: Colors.white,size: 11.sp,),
          SizedBox(height: 5.h,),

        ],
      ),
    );
  }
}