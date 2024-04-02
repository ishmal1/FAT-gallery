import 'package:flutter/cupertino.dart';
import 'package:login_signup/constants/small_text.dart';


class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  const IconAndTextWidget({Key? key,
    required this.icon,
    required this.text,
    required this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: iconColor,size: MediaQuery.of(context).size.width/17.1, ),
        SizedBox(width: MediaQuery.of(context).size.width/82, ),
        SmallText(text: text,),
        SizedBox(width: MediaQuery.of(context).size.width/82, ),

      ],
    );
  }
}
