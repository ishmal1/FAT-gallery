import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double? size;
  FontWeight fontWeight;
  TextOverflow overFlow;
  BigText({Key? key, this.color = const Color(0xFF332d2b),
    required this.text,
    this.size=20,
    this.overFlow=TextOverflow.ellipsis, this.fontWeight = FontWeight.w800,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontFamily: "Roboto",
        fontSize: size,
        letterSpacing: 1.0,
      ),
    );
  }
}
