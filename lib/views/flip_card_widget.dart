import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../providers/card_provider.dart';
import '../utils/color_constant.dart';
import '../utils/image_constant.dart';


class CreditCardFlip extends StatefulWidget {
  @override
  _CreditCardFlipState createState() => _CreditCardFlipState();
}

class _CreditCardFlipState extends State<CreditCardFlip> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Adjust the duration as needed
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut, // Adjust the curve as needed
      ),
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreditCardFlipModel>(
      builder: (context, model, _) {
        return Center(
          child: GestureDetector(
            onTap: () {
              model.switchCard();
              if (_animationController!.status == AnimationStatus.completed) {
                _animationController!.reverse();
              } else {
                _animationController!.forward();
              }
            },
            child: AnimatedBuilder(
              animation: _animationController!,
              builder: (context, child) {
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(pi * _animation!.value),
                  alignment: Alignment.center,
                  child: child,
                );
              },
              child: model.isFlipped ? _buildRear() : _buildFront(), // Reorder front and rear widgets based on flipped state
            ),
          ),
        );
      },
    );
  }


  Widget _buildFront() {
    return GestureDetector(
        onTap: (){
          final model = Provider.of<CreditCardFlipModel>(context, listen: false);
          model.switchCard();
        },
        child: Container(
        key: ValueKey<bool>(false),
    child: Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Container(
        color: Colors.transparent,
        width: Get.width,
        height: 120.h,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          elevation: 0.0,
          color: ColorConstants.visa_card_color,
          child: Padding(
            padding: EdgeInsets.only(top: 7.h, right: 15.w, left: 15.w),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My credit card",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 45.w,
                      height: 25.h,
                      child: Image(image: AssetImage(ImageConstant.visa)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 18.h,
                ),
                Text(
                  "4242 4242 4242 4242",
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                     "Faizan Ahmed",
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "12/34",
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    ));
  }

  Widget _buildRear() {

    return GestureDetector(
        onTap: (){
          final model = Provider.of<CreditCardFlipModel>(context, listen: false);
          model.switchCard();
        },
        child: Container(
        key: ValueKey<bool>(true),
    child: Padding(
      padding: EdgeInsets.only(top: 7.h, right: 15.w, left: 15.w),
      child: Container(
        color: Colors.transparent,
        width: Get.width,
        height: 120.h,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          elevation: 0.0,
          color: ColorConstants.visa_card_color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Customer Service: +123 45 67.890.12.34",
                style: TextStyle(
                  fontSize: 6.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.maxFinite,
                height: 30.h,
                color: Colors.black,
              ),
              SizedBox(height: 2.h,),
              Padding(
                padding: EdgeInsets.only(left: 15.w,right: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Authorized Signature",
                      style: TextStyle(
                        fontSize: 6.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Not Valid Unless Signed",
                      style: TextStyle(
                        fontSize: 6.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 2.h,),

              Container(
                width: 290.w,
                height: 30.h,
                color: Colors.white,
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Text("567",style: TextStyle(fontSize: 9.sp),),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    ImageConstant.visa1,
                    width: 35.w,
                    height: 35.h,
                  ),
                  Image.asset(
                    ImageConstant.master1,
                    width: 35.w,
                    height: 35.h,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    )));
  }
}
