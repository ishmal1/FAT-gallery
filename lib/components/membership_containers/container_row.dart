import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/big_text.dart';
import '../../constants/small_text.dart';


class CurrentMembershipContainer extends StatelessWidget {
  List<Color> color =[];
  final String bigText;
  final String smallText;
  final double height;
  final double width;
  CurrentMembershipContainer({Key? key,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // SizedBox(width: 30.w,),
          BigText(text: bigText,size: 14.sp, color: Colors.white,),
          // SizedBox(width: 110.w,),
          SmallText(text: smallText,size: 12.sp,color: Colors.white,),

        ],
      ),
    );
  }
}