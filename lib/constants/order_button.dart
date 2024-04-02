import 'package:flutter/material.dart';


class OrderButton extends StatelessWidget {
  bool? isResponsive;
  double? width;
  final Function() onPressed;
  OrderButton({Key? key, this.width=120, this.isResponsive=false, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width/1.11,
        height: MediaQuery.of(context).size.height/18.23,
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.deepOrange),
        child: Center(child: Text("Order Now",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width/23,fontWeight: FontWeight.w600),)),
      ),
    );
  }
}