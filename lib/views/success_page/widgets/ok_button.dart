import 'package:flutter/material.dart';
import 'package:login_signup/utils/color_constant.dart';
import 'package:login_signup/views/home_screen/buyer_home_screen.dart';
import 'package:login_signup/widgets/custom_button.dart';


class OkButton extends StatefulWidget {
  const OkButton({Key? key}) : super(key: key);

  @override
  _OkButtonState createState() => _OkButtonState();
}

class _OkButtonState extends State<OkButton> {
  @override
  Widget build(BuildContext context) {
    return custom_button(
      label: 'OK',
      backgroundcolor: ColorConstants.purple,
      textcolor: Colors.white,
      function: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => home_screen()));

      },);
  }
}
