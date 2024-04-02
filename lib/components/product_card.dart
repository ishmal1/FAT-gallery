import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/color_constant.dart';
import '../../../../utils/image_constant.dart';

// ignore: use_key_in_widget_constructors, camel_case_types
class product_card extends StatelessWidget {
  final double circleRadius = 100.0;
  final double circleBorderWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 30),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: circleRadius / 2.0),
              child: Container(
                color: Colors.transparent,
                width: Get.width / 2,
                height: Get.height / 3.4,
                child: InkWell(
                  onTap: () {
                    // Get.to(product_info());
                  },
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 90),
                      child: Column(
                        children: <Widget>[
                          const Text(
                            "Apple Watch",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                          const Text(
                            "Series 6",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              "\$ 359",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.purple),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 160,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Padding(
                padding: EdgeInsets.all(circleBorderWidth),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            ImageConstant.watch,
                          ))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
