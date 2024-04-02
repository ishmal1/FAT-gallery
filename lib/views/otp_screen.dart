import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/color_constant.dart';
import '../../../utils/image_constant.dart';
import '../../widgets/custom_button.dart';
import '../components/otp_boxes.dart';
import '../components/resend_timer_button.dart';


class OTPScreen extends StatefulWidget {
  final FocusNode? focusNode;
  const OTPScreen({Key? key, this.focusNode}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: ColorConstants.purple,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: ColorConstants.white),
          elevation: 0,
          backgroundColor: ColorConstants.purple,
          title: Text(
            "Forgot Password",
            style: TextStyle(
                color: ColorConstants.white,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: SizedBox(
                  width: Get.width * 100,
                  height: Get.height / 3.5,
                  child: Image(image: AssetImage(ImageConstant.lock))),
            ),
            Expanded(
              child: SizedBox(
                  width: Get.width * 100,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20))),
                    color: ColorConstants.white,
                    child: Padding(
                      padding:
                      const EdgeInsets.only( right: 30, left: 30),
                      child: Column(
                        children: [
                          const SizedBox(
                            width: 50,
                            child: Divider(
                              color: Color(0xff5956E9),
                              thickness: 3,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            "Verification",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: 240.w,
                            height: 60.h,
                            child: Column(
                              children: [
                                const Text(
                                  "Enter the verification code we",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Text(
                                  "just sent on your email",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Text(
                                  "address.",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const OtpBoxes(),
                          const ResendTimerButton(),
                          const SizedBox(
                            height: 20,
                          ),
                          custom_button(
                            label: 'Verify',
                            backgroundcolor: ColorConstants.purple,
                            textcolor: ColorConstants.white,
                            function: () async {

                            },
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
