import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:login_signup/views/admin/admin_home_screen/components/admin_tab.dart';
import 'package:login_signup/views/admin/admin_home_screen/components/users_tab.dart';
import 'package:login_signup/views/admin/help&support_screen.dart';
import 'package:login_signup/views/admin/login_page/admin_login.dart';
import 'package:login_signup/views/admin/userlist_screen/approveduserlist_screen.dart';
import 'package:login_signup/views/admin/notifications_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../components/drawer_view.dart';
import '../../../controller/auth_controller.dart';
import '../../../firebase/auth_service/auth_service.dart';
import '../../../firebase/firestore_fetch_data/fetch_user_data.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/image_constant.dart';
import '../adminlist_screen/approvedadminlist_screen.dart';
import '../galleries_screen/waitinggallery_screen.dart';
import 'components/gallery_tab.dart';

class adminhome_screen extends StatefulWidget {
  const adminhome_screen({Key? key}) : super(key: key);

  @override
  State<adminhome_screen> createState() => _adminhome_screenState();
}

class _adminhome_screenState extends State<adminhome_screen> {

  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 48)
  ];
  List<_PieData> pieData = [
    _PieData('Jan', 30, 'Purchased'),
    _PieData('Feb', 10, 'Not Purchased'),
  ];


  // @override
  // void initState() {
  //   super.initState();
  //   fetchData();
  // }



  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey();

    return Scaffold(
      drawer: Drawer(child: DrawerView()),
      key: _key,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorConstants.grey,
        automaticallyImplyLeading: true,
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.more_vert),
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context){
                return [
                  PopupMenuItem<int>(
                      value: 0,
                      child: TextButton.icon(
                          onPressed: (){
                            // Get.to(notifications_screen());
                          }, icon: Icon(Icons.notifications_active), label: Text("Notifications",style: TextStyle(color: Colors.black),))),

                  PopupMenuItem<int>(
                      value: 1,
                      child: TextButton.icon(
                          onPressed: (){
                            Get.to(helpsupport_screen());
                          }, icon: Icon(Icons.help), label: Text("Help & Support",style: TextStyle(color: Colors.black),))),

                  PopupMenuItem<int>(
                      value: 2,
                      child: TextButton.icon(
                          onPressed: (){
                            Timer(const Duration(seconds: 4), () {
                              AuthController().showLoaderDialog(context, "signing out");
                            });
                            FirebaseAuth auth = FirebaseAuth.instance;
                            auth.signOut();
                            Get.offAll(const adminlogin_screen());
                          }, icon: Icon(Icons.logout), label: Text("Logout",style: TextStyle(color: Colors.black),))),
                ];
              },
              onSelected:(value){
                if(value == 0){
                  print("My account menu is selected.");
                }else if(value == 1){
                  print("Settings menu is selected.");
                }else if(value == 2) {
                  print("Logout menu is selected.");
                }else if(value == 3){
                  print("Logout menu is selected.");
                }
              }
          ),
        ],
        iconTheme: IconThemeData(
          color: ColorConstants.black,
        ),
      ),


      backgroundColor: ColorConstants.grey,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageConstant.adminBack,),
                    fit: BoxFit.cover)
            ),
          ),

          Center(
            child: SizedBox(
                height: 600.h,
                width: 320.w,
                child: Card(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 15.h),
                          child: Row(
                            children: [
                             CircleAvatar(
                                radius: 5.sp,
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.transparent,
                                backgroundImage:  AssetImage(ImageConstant.avatar),
                              ),
                              SizedBox(width: 5.w,),
                              SizedBox(
                                  width: 50.w,
                                  child: Text("Tayyab",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 4.sp,overflow: TextOverflow.ellipsis),)),
                              SizedBox(width: 210.w,),
                              Text("Contact Us",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 4.sp,),),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h,),
                    
                        SizedBox(
                            width: 320.w,
                            child: Divider(color: Colors.black,thickness: 2,)),
                        SizedBox(height: 3.h,),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorConstants.purple,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          height: 40.h,
                          width: 293.w,
                          child: Center(child: Text("Admin Dashboard",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                        ),
                        SizedBox(height: 8.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 70.w,
                                height: 60.h,
                                child: Card(
                                  color: const Color.fromRGBO(232, 30, 99, 4),
                                  child: Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              color: const Color.fromRGBO(205, 27, 87, 4),
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          height: 60.h,
                                          width: 20.w,
                                          child: const Icon(Icons.payments,color: Colors.white,)),
                                      SizedBox(width: 5.w,),
                                      SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Revenue",style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 5.sp),),
                                            Text("0.0",style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal),),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(width: 5.w,),
                            GestureDetector(
                              onTap: (){
                                Get.to(const approveduserlist_screen());
                              },
                              child: users_tab(),
                            ),
                            SizedBox(width: 5.w,),
                            GestureDetector(
                              onTap: (){
                                Get.to(gallerylist_screen());
                              },
                              child: gallery_tab(),
                            ),
                            SizedBox(width: 5.w,),
                            GestureDetector(
                              onTap: (){
                                Get.to(approvedadminlist_screen());
                              },
                              child: admin_tab(),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h,),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w,right: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: ColorConstants.purple,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                height: 40.h,
                                width: 150.w,
                                child: Center(child: Text("Anaylytics",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                              ),
                              SizedBox(width: 10.w,),
                    
                              Container(
                                decoration: BoxDecoration(
                                    color: ColorConstants.purple,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                height: 40.h,
                                width: 100.w,
                                child: Center(child: Text("Purchasings",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w,right: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 330.h,
                                width: 150.w,
                                child: Card(
                                  color: Colors.white,
                                  surfaceTintColor: Colors.white,
                                  child: Center(
                                    child: SfCartesianChart(
                                        backgroundColor: Colors.white,
                                        primaryXAxis: CategoryAxis(),
                                        // Chart title
                                        // Enable legend
                                        legend: Legend(isVisible: true, position: LegendPosition.bottom),
                                        // Enable tooltip
                                        tooltipBehavior: TooltipBehavior(enable: true),
                                        series: <ChartSeries<_SalesData, String>>[
                                          ColumnSeries<_SalesData, String>(
                                              color: ColorConstants.purple,
                                              dataSource: data,
                                              xValueMapper: (_SalesData sales, _) => sales.year,
                                              yValueMapper: (_SalesData sales, _) => sales.sales,
                                              name: '',
                                              // Enable data label
                                              dataLabelSettings: DataLabelSettings(isVisible: true)
                    
                                          )
                                        ]),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w,),
                              SizedBox(
                                height: 330.h,
                                width: 100.w,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.w,right: 10.w,),
                                  child: Card(
                                    color: Colors.white,
                                    surfaceTintColor: Colors.white,
                                    child: Center(
                                        child: SfCircularChart(
                                          backgroundColor: Colors.white,
                                            title: ChartTitle(text: "Purchased Products"),
                                            legend: Legend(isVisible: true, position: LegendPosition.bottom),
                                            palette: <Color>[
                                              Colors.purple.shade800,
                                              ColorConstants.purple,
                                            ],
                                            series: <PieSeries<_PieData, String>>[
                                              PieSeries<_PieData, String>(
                                                strokeColor: ColorConstants.purple,
                                                explode: true,
                                                explodeIndex: 0,
                                                dataSource: pieData,
                                                xValueMapper: (_PieData data, _) => data.text,
                                                yValueMapper: (_PieData data, _) => data.yData,
                                                dataLabelMapper: (_PieData data, _) => data.yData.toString(),
                                                dataLabelSettings: DataLabelSettings(isVisible: true),
                                                animationDuration: 1000,
                                              ),
                                            ])),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    
                      ],
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}




class _SalesData {
  _SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class _PieData {
  _PieData(this.xData, this.yData, this.text);
  final String xData;
  final num yData;
  final String text;
}
