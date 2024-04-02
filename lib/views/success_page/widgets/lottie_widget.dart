import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class LottieWidget extends StatelessWidget {
  const LottieWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Lottie.network(
            "https://assets8.lottiefiles.com/packages/lf20_jz2wa00k.json",
            height: MediaQuery.of(context).size.height/2.7,    /// 300
            width: MediaQuery.of(context).size.width/1.3,      /// 300
            repeat: false
        ),
    );
  }
}
