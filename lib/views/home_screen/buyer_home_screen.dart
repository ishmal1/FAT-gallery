import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:full_screen_image/full_screen_image.dart';

import '../../../../utils/color_constant.dart';
import '../../../utils/image_constant.dart';
import '../../components/bottom_bar.dart';
import '../../components/buyer_drawer.dart';
import '../../components/home_screen_component.dart';
import '../../firebase/auth_service/auth_service.dart';

class home_screen extends StatefulWidget {
  const home_screen({key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {

  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: ColorConstants.purple,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.0,
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: const Buyer_Drawer(),
      child: Scaffold(
        bottomNavigationBar: Bottom_Bar(),
        backgroundColor: ColorConstants.grey,
        appBar: AppBar(
          backgroundColor: ColorConstants.grey,
          elevation: 0.0,
          title: Text(
            'Welcome',
            style: TextStyle(
                fontSize: 18.sp,
                color: ColorConstants.black,fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: CircleAvatar(
                radius: 20.sp,
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                child: Image(image: AssetImage(ImageConstant.avatar,),),
              )
            ),
          ],
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            color: ColorConstants.black,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: const home_screen_Component(),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // Managing Drawer state through the <Drawer>Controller.
    _advancedDrawerController.showDrawer();
  }
}
