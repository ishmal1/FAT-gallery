import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/color_constant.dart';
import '../utils/connection.dart';
import '../utils/image_constant.dart';
import '../widgets/custom_button.dart';

class no_internet_screen extends StatelessWidget {
  const no_internet_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.grey,
      body: Padding(
        padding: EdgeInsets.only(top: 200.h,),
        child: Center(
          child: Column(
            children: [
              Image(
                  width: 290.w,
                  height: 170.h,
                  fit: BoxFit.cover,
                  image: AssetImage(ImageConstant.wifi,)),
              SizedBox(
                width: 300.w,
                  height: 33.h,
                  child: Text("No internet Connection",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 27.sp),)),
               SizedBox(
                   width: 300.w,
                   height: 48.h,
                  child: Column(
                    children: [
                      Text("Your internet connection is currently not",style: TextStyle(color: Colors.black.withOpacity(0.57),fontWeight: FontWeight.w400,fontSize: 15.sp),),
                   Text("available please check or try again.",style: TextStyle(color: Colors.black.withOpacity(0.57),fontWeight: FontWeight.w400,fontSize: 15.sp),)

            ],
                  )),
              custom_button(label: "Try again", backgroundcolor: ColorConstants.btnColor, textcolor: Colors.white, function: (){
                _checkInternetConnection(context);
              })
            ],
          ),
        ),
      ),
    );
  }
  void _checkInternetConnection(BuildContext context) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    bool isConnected = connectivityResult != ConnectivityResult.none;
    if (isConnected) {
      Navigator.pop(context); // Close the "No Internet" screen
    } else {
      print("Still No Internet");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No internet connection'),
          duration: Duration(seconds: 2),
        ),
      );
      }
      // Still no internet connection
      // Show an appropriate message or handle the scenario
    }
  }

