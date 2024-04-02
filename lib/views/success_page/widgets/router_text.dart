import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class RouterText extends StatelessWidget {
  const RouterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Order Placed Successfully", style: TextStyle(color: Colors.black54, fontSize: 12.sp,)),   /// 25
      );
  }
}
