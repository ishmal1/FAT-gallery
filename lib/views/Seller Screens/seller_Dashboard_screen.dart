import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../utils/image_constant.dart';
import '../../components/seller_dashbaord_components.dart';
import '../../components/seller_drawer.dart';
import '../../utils/color_constant.dart';
import '../notifications/notifications_page.dart';

class Seller_dashbaord extends StatefulWidget {
  @override
  _Seller_dashbaordState createState() => _Seller_dashbaordState();
}

class _Seller_dashbaordState extends State<Seller_dashbaord> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _hasNewNotifications = false;
  bool _allNotificationsViewed = false;

  @override
  void initState() {
    super.initState();
    listenToNotificationChanges();
  }


  void listenToNotificationChanges() {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;

    if (userId != null) {
      _firestore
          .collection('Notifications')
          .doc(userId)
          .collection('userNotifications')
          .snapshots()
          .listen((snapshot) {
        setState(() {
          _hasNewNotifications = snapshot.docs.isNotEmpty;
          _allNotificationsViewed = snapshot.docs.every((doc) => doc['viewed'] == true);

          if (_allNotificationsViewed) {
            _hasNewNotifications = false;
          }
        });
      });
    }
  }



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
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SellerDrawer(),
      child: Scaffold(
        backgroundColor: ColorConstants.grey,
        appBar: AppBar(
          backgroundColor: ColorConstants.grey,
          elevation: 0.0,
          title: Text(
            'Seller Dashbaord',
            style: TextStyle(color: ColorConstants.black,fontWeight: FontWeight.bold,fontSize: 18.sp),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: InkWell(
                onTap: (){
                  Get.to(notifications_screen());
                },
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: _hasNewNotifications ? Icon(Icons.notifications_active,color: Colors.red,): Image(image: AssetImage(ImageConstant.bell)),
                ),
              ),
            ),
          ],

          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            color: ColorConstants.black,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: SellerDashboardComponent(),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // Managing Drawer state through the <Drawer>Controller.
    _advancedDrawerController.showDrawer();
  }
}
