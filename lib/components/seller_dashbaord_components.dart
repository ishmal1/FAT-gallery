import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:login_signup/components/pie_chart.dart';
import 'package:login_signup/views/galleries_screens/waitinggallerieslist_screen.dart';
import '../controller/product_controller.dart';
import '../controller/seller_controller.dart';
import '../firebase/auth_service/auth_service.dart';
import '../utils/color_constant.dart';
import '../utils/image_constant.dart';
import '../views/galleries_screens/approvedgalleries_screen.dart';
import '../views/products_pages/restaurant_admin.dart';
import '../views/seller_order_history.dart';

class SellerDashboardComponent extends StatefulWidget {
  const SellerDashboardComponent({Key? key}) : super(key: key);

  @override
  State<SellerDashboardComponent> createState() => _SellerDashboardComponentState();
}

class _SellerDashboardComponentState extends State<SellerDashboardComponent> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.grey,
      body: Column(
        children: [
          Container(
            width: Get.width * 100,
            height: Get.height / 3,
            child: const PieChartSample3(),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: SizedBox(
                  width: Get.width / 1.2,
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    children: <Widget>[
                      Card_Widget(
                        image: ImageConstant.money,
                        label: 'Revenue 1',
                        function: () {
                          Get.to(seller_order_history());
                        },
                      ),

                      Card_Widget(
                          image: ImageConstant.users,
                          label: '2',
                          function: () {
                            Get.to(const RestaurantAdmin());
                          }),
                      Card_Widget(
                          image: ImageConstant.approve,
                          label: 'Approved 2',
                          function: () {
                            Get.to(const approved_galleries());
                          }),
                      Card_Widget(
                          image: ImageConstant.waiting,
                          label: 'Waiting 1',
                          function: () {
                            Get.to(const waiting_galleries());
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Card_Widget extends StatelessWidget {
  Card_Widget(
      {Key? key,
      required this.image,
      required this.label,
      required this.function})
      : super(key: key);
  String image;
  String label;
  VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Card(
        surfaceTintColor: Colors.white,
        elevation: 30,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        color: ColorConstants.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage(image)),
            SizedBox(
              height: 8.sp,
            ),
            Text(
              label,
              style: TextStyle(
                  color: ColorConstants.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
