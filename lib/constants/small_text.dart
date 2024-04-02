import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  // FontWeight fontWeight;
  double height;

  SmallText({Key? key, this.color = const Color(0xFFccc7c5),
    required this.text,
    this.height=1.2,
    this.size=12,
    // this.fontWeight = FontWeight.w400,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontFamily: "Roboto",
        fontSize: size,
        // fontWeight: fontWeight,
        height: height,

      ),
    );
  }
}
