
import 'package:flutter/material.dart';

class LargeText extends StatelessWidget {
  final double? size;
  final String text;
  FontWeight  fontWeight;
  final Color color;

  LargeText({Key? key,
    this.fontWeight = FontWeight.bold,
    this.size,
    required this.text,
    this.color=Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size??MediaQuery.of(context).size.width/13,
        fontWeight: fontWeight,
      ),
    );
  }
}
