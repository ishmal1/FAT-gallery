import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../utils/color_constant.dart';



class OtpBoxes extends StatefulWidget {
  const OtpBoxes({Key? key}) : super(key: key);

  @override
  State<OtpBoxes> createState() => _OtpBoxesState();
}

class _OtpBoxesState extends State<OtpBoxes> {
  String otp = "";
  String currentText = "";
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: 8.h, horizontal: 20.w),
        child: Column(
          children: [
            PinCodeTextField(
              appContext: context,
              textStyle: const TextStyle(
                backgroundColor: Colors.transparent,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              pastedTextStyle: const TextStyle(
                backgroundColor: Colors.transparent,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              length: 4,
              backgroundColor: Colors.transparent,
              obscureText: false,
              obscuringCharacter: '*',
              // obscuringWidget: FlutterLogo(
              //   size: 24,
              // ),
              blinkWhenObscuring: true,
              animationType: AnimationType.fade,
              validator: (v) {
                if (v!.length < 4) {
                  return "                                 \n                                Please enter OTP";
                } else {
                  return null;
                }
              },
              pinTheme: PinTheme(
                  selectedColor: Colors.white,
                  selectedFillColor: ColorConstants.purple,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(20),
                  fieldHeight: 45.h,
                  fieldWidth: 55.w,
                  inactiveColor: Colors.black,
                  activeFillColor: Colors.white,
                  inactiveFillColor: ColorConstants.purple,
                  activeColor: ColorConstants.purple,
              ),
              cursorColor: Colors.black,
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              // errorAnimationController: errorController,
              // controller: textEditingController,
              keyboardType: TextInputType.number,
              boxShadows: const [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black12,
                  blurRadius: 0,
                )
              ],
              onCompleted: (v) {
                otp = v;
              },

              onChanged: (value) {
                if (kDebugMode) {
                  print(value);
                }
                setState(() {
                  currentText = value;
                });
                otp = value;
              },
              beforeTextPaste: (text) {
                if (kDebugMode) {
                  print("Allowing to paste $text");
                }
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            ),

          ],
        ));
  }
}
