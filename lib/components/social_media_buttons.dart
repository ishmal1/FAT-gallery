import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/image_constant.dart';


class SocialMediaButtons extends StatefulWidget {
  const SocialMediaButtons({Key? key}) : super(key: key);

  @override
  State<SocialMediaButtons> createState() => _SocialMediaButtonsState();
}

class _SocialMediaButtonsState extends State<SocialMediaButtons> {
  // googleSignIn() async{
  //   GoogleSignIn _googleSignIn = GoogleSignIn(
  //       scopes: [
  //         'email',
  //         'https://www.googleapis.com/auth/user.emails.read',
  //
  //         'https://www.googleapis.com/auth/user.birthday.read',
  //
  //         'https://www.googleapis.com/auth/userinfo.profile',
  //       ],
  //       clientId:  '268521217559-1mvutp5a07tta074jj5stiq7nqncvjm0.apps.googleusercontent.com'
  //
  //   );
  //
  //   try {
  //     var googleInfo =
  //     await _googleSignIn.signIn();
  //     print(googleInfo);
  //   } catch (error) {
  //     print(error);
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 5,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.black12,
                  width: MediaQuery.of(context).size.width / 600),
              borderRadius: BorderRadius.circular(10)),
          child: IconButton(
            splashRadius: 1,
            onPressed: () {
              //
              // FacebookAuth.instance.login(
              //     permissions: ["public_profile", "email"]).then((value){
              //   FacebookAuth.instance.getUserData().then((value){
              //
              //   });
              // });
            },
            icon: Image.asset(ImageConstant.facebook),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width / 20),
        Container(
          width: MediaQuery.of(context).size.width / 5,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.black12,
                  width: MediaQuery.of(context).size.width / 600),
              borderRadius: BorderRadius.circular(10)),
          child: IconButton(
            splashRadius: 1,
            onPressed: () {
              // googleSignIn();
            },
            icon: Image.asset(ImageConstant.google),
          ),
        ),
        // SizedBox(width: MediaQuery.of(context).size.width / 20),
        // Container(
        //   width: MediaQuery.of(context).size.width / 5,
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       border: Border.all(
        //           color: Colors.black12,
        //           width: MediaQuery.of(context).size.width / 600)),
        //   child: IconButton(
        //     splashRadius: 1,
        //     onPressed: () {},
        //     icon: Image.asset(
        //       AppImages.apple,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
