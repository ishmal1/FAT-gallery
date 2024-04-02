import 'package:flutter/material.dart';
import 'package:login_signup/views/success_page/widgets/lottie_widget.dart';
import 'package:login_signup/views/success_page/widgets/ok_button.dart';
import 'package:login_signup/views/success_page/widgets/router_text.dart';



class success_page extends StatelessWidget {
  const success_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LottieWidget(),
            const RouterText(),
            SizedBox(height: MediaQuery.of(context).size.height/68.3,),
            const OkButton(),
          ]
      ),
    );
  }
}