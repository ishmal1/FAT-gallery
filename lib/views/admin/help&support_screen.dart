import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login_signup/views/admin/admin_profile_screen.dart';
import 'package:login_signup/views/admin/admin_home_screen/adminhome_screen.dart';
import 'package:login_signup/views/admin/notifications_screen.dart';

import '../../components/admin_textfield_screen.dart';
import '../../components/drawer_view.dart';
import '../../controller/auth_controller.dart';
import '../../firebase/firestore_fetch_data/fetch_user_data.dart';
import '../../utils/color_constant.dart';
import '../../utils/image_constant.dart';
import '../../widgets/custom_button.dart';
import 'login_page/admin_login.dart';

class helpsupport_screen extends StatefulWidget {
  const helpsupport_screen({Key? key}) : super(key: key);

  @override
  State<helpsupport_screen> createState() => _helpsupport_screenState();
}

class _helpsupport_screenState extends State<helpsupport_screen> {
  bool _isLoading = false;

  void _submitForm() {
    setState(() {
      _isLoading = true;
    });

    // Simulating a delay of 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Column(
            children: <Widget>[
              Text("Thanks for contacting us",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500)),
            ],
          ),
          content: Text("We will entertain your query in 12 hours",
              style: TextStyle(color: ColorConstants.purple)),
          actions: <Widget>[
            Divider(color: Colors.black54),
            CupertinoDialogAction(
              child: Text("Ok", style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );

      setState(() {
        _isLoading = false;
      });
    });
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController problemController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: DrawerView()),
      key: _key,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorConstants.grey,
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.more_vert),
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                      value: 0,
                      child: TextButton.icon(
                          onPressed: () {
                            Get.to(adminhome_screen());
                          },
                          icon: Icon(Icons.home),
                          label: Text(
                            "Dashboard",
                            style: TextStyle(color: Colors.black),
                          ))),
                  PopupMenuItem<int>(
                      value: 1,
                      child: TextButton.icon(
                          onPressed: () {
                            // Get.to(notifications_screen());
                          },
                          icon: Icon(Icons.notifications_active),
                          label: Text(
                            "Notifications",
                            style: TextStyle(color: Colors.black),
                          ))),
                  PopupMenuItem<int>(
                      value: 2,
                      child: TextButton.icon(
                          onPressed: () {
                            Get.to(admin_profile_screen());
                          },
                          icon: Icon(Icons.person),
                          label: Text(
                            "Profile",
                            style: TextStyle(color: Colors.black),
                          ))),
                  PopupMenuItem<int>(
                      value: 3,
                      child: TextButton.icon(
                          onPressed: () {
                            Timer(const Duration(seconds: 4), () {
                              AuthController().showLoaderDialog(context, "signing out");
                            });
                            FirebaseAuth auth = FirebaseAuth.instance;
                            auth.signOut();
                            Get.offAll(const adminlogin_screen());
                          },
                          icon: Icon(Icons.logout),
                          label: Text(
                            "Logout",
                            style: TextStyle(color: Colors.black),
                          ))),
                ];
              },
              onSelected: (value) {
                if (value == 0) {
                  print("My account menu is selected.");
                } else if (value == 1) {
                  print("Settings menu is selected.");
                } else if (value == 2) {
                  print("Logout menu is selected.");
                } else if (value == 3) {
                  print("Logout menu is selected.");
                }
              }),
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
                    image: AssetImage(
                      ImageConstant.adminBack,
                    ),
                    fit: BoxFit.cover)),
          ),
          Center(
            child: SizedBox(
                height: 600.h,
                width: 200.w,
                child: Card(
                  color: ColorConstants.white,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w, top: 20.h),
                          child: Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.help_outline,
                                  size: 8.sp,
                                  color: ColorConstants.purple,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  "Help & Support",
                                  style: TextStyle(
                                      fontSize: 7.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 80,
                              ),
                              child: Text(
                                "Email :",
                                style: TextStyle(
                                  fontSize: 4.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              width: 70.w,
                              child: AdminTextFormFieldWidget(
                                fillColor: Colors.white,
                                textInputType: TextInputType.text,
                                actionKeyboard: TextInputAction.next,
                                controller: nameController,
                                hintText: 'tayyab',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 80,
                              ),
                              child: Text(
                                "Describe the problem you are having:",
                                style: TextStyle(
                                  fontSize: 4.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              width: 120.w,
                              child: AdminTextFormFieldWidget(
                                fillColor: Colors.white,
                                textInputType: TextInputType.text,
                                actionKeyboard: TextInputAction.next,
                                controller: problemController,
                                hintText: "Enter your problem here",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 80,
                              ),
                              child: Text(
                                "Give us details:",
                                style: TextStyle(
                                  fontSize: 4.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              width: 120.w,
                              child: AdminTextFormFieldWidget(
                                maxLines: 15,
                                fillColor: Colors.white,
                                textInputType: TextInputType.text,
                                actionKeyboard: TextInputAction.next,
                                controller: messageController,
                                hintText: "Enter your problem here",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        // SizedBox(
                        //     width: 100.w,
                        //     child: custom_button(
                        //         label: "Submit",
                        //         backgroundcolor: ColorConstants.purple,
                        //         textcolor: ColorConstants.white,
                        //         function: (){},),),
                        SizedBox(
                          width: 100.w,
                          height: 35.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstants.purple,
                              minimumSize: const Size(270, 50),
                              maximumSize: const Size(270, 50),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                              elevation: 30,
                            ),
                            onPressed: _isLoading ? null : _submitForm,
                            child: _isLoading
                                ? CircularProgressIndicator()
                                : Text(
                                    "Submit",
                                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
                                  ),
                          ),
                        ),
                        SizedBox(height: 30.h,),
                      ],
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
