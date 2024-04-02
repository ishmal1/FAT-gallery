import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final String textLabel;
  final String iconPath;
  final double elevation;
  final Color backgroundColor;
  final Color? borderColor;
  final void Function()? onTap;

  const SignInButton({
    Key? key,
    required this.textLabel,
    required this.iconPath,
    required this.elevation,
    required this.backgroundColor,
    required this.onTap,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 20.5),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          primary: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(width: MediaQuery.of(context).size.width / 274.2,color: borderColor??Colors.transparent),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 51.28,
            horizontal: MediaQuery.of(context).size.width / 68.5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  iconPath,
                ),
                height: MediaQuery.of(context).size.height / 40,
                width: MediaQuery.of(context).size.width / 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 29.3,
              ),
              Text(
                textLabel,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 29.38,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
