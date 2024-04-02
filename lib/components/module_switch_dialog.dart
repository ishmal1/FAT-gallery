import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color_constant.dart';


class ModuleSwitchDialog extends StatefulWidget {
  @override
  _ModuleSwitchDialogState createState() => _ModuleSwitchDialogState();
}

class _ModuleSwitchDialogState extends State<ModuleSwitchDialog> {


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(left: 18.w,right: 18.w),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: ColorConstants.purple,
          ),
            onPressed: (){
              if(tenant == true){
                tenant = false;
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //     AppRoutes.OwnerHome, (Route<dynamic> route) => false);

              }else{
                tenant = true;
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //     AppRoutes.TenantHome, (Route<dynamic> route) => false);
              }
              print(tenant);

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
      title: tenant == true ? Text('Switching to Seller',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
      ) : Text('Switching to Buyer',
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
  }
}