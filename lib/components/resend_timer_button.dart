import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

import '../../../utils/color_constant.dart';


class ResendTimerButton extends StatelessWidget {
  const ResendTimerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OtpTimerButtonController controller = OtpTimerButtonController();

    return Center(
      child: OtpTimerButton(
        backgroundColor: ColorConstants.purple,
        controller: controller,
        text: Text(
          "Resend code",
          style: TextStyle(color: Colors.black,fontSize: 13.sp)
        ),
        duration: 60,
        radius: 8,
        textColor: Colors.black54,
        buttonType: ButtonType.text_button, // or ButtonType.outlined_button
        loadingIndicator: CircularProgressIndicator(
          strokeWidth: 2,
          color: ColorConstants.purple,
        ),
        loadingIndicatorColor: ColorConstants.purple,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Resended Successfully")));
        },
      ),
    );
  }
}
