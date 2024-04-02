import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:login_signup/providers/login_screen_providers.dart';
import 'package:provider/provider.dart';
import '../../../../utils/color_constant.dart';
import '../../../../utils/image_constant.dart';
import '../../widgets/form_fields.dart';
import '../widgets/custom_button.dart';

// ignore: camel_case_types
class forgot_password_screen extends StatefulWidget {
  const forgot_password_screen({key});

  @override
  State<forgot_password_screen> createState() => _forgot_password_screenState();
}

class _forgot_password_screenState extends State<forgot_password_screen> {

  final formKey = GlobalKey<FormState>();

  TextEditingController emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.purple,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorConstants.white),
        elevation: 0,
        backgroundColor: ColorConstants.purple,
        centerTitle: true,
        title: Text(
          "Forgot Password",
          style: TextStyle(
              color: ColorConstants.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: SizedBox(
                width: Get.width * 100,
                height: Get.height / 3.5,
                child: Image(image: AssetImage(ImageConstant.forgot))),
          ),
          Expanded(
            child: SizedBox(
                width: Get.width * 100,
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  color: ColorConstants.white,
                  child: Padding(
                    padding: EdgeInsets.only(right: 25.w, left: 25.w),
                    child: Consumer<LoginPageProviders>(
                      builder: (context, provider, child) {
                        return Form(
                          key: formKey,
                          child: Column(
                            children: [

                              SizedBox(
                                width: 45.h,
                                child: Divider(
                                  color: Color(0xff5956E9),
                                  thickness: 3,
                                ),
                              ),
                               SizedBox(
                                height: 25.h,
                              ),
                              Text(
                                "Forgot Password",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 40.h,
                              ),
                              form_fields(
                                onChanged: (p0) {
                                  provider.emailValidation(p0);
                                },
                                onclick: () {},
                                secure: false,
                                fieldtext: "",
                                hinttext: "Enter Your Email Address",
                                icon: Icons.mail_outline_rounded,
                                label: "Email",
                                controller: emailcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an email';
                                  }
                                  // Additional validation logic can be added here
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 40.h,
                              ),

                              custom_button(
                                  label: 'Forgot Password',
                                  backgroundcolor: ColorConstants.purple,
                                  textcolor: ColorConstants.white,
                                  function: () async {
                                    if (formKey.currentState!.validate()) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // Show circular progress indicator while sending the password reset email
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      );

                                      try {

                                        Navigator.pop(
                                            context); // Close the dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            // Show success dialog
                                            return CupertinoAlertDialog(
                                              title: Text('Success'),
                                              content: Text(
                                                  'Password reset email sent.'),
                                              actions: <Widget>[
                                                CupertinoDialogAction(
                                                  child: Text('OK'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } catch (error) {
                                        Navigator.pop(
                                            context); // Close the dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            // Show error dialog
                                            return CupertinoAlertDialog(
                                              title: Text('Error'),
                                              content: Text(
                                                  'Failed to send password reset email.'),
                                              actions: <Widget>[
                                                CupertinoDialogAction(
                                                  child: Text('OK'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    } else {
                                      // Show validation error message
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CupertinoAlertDialog(
                                          title: Text(
                                            "Validation Error",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          content: Text(
                                            "Please fill in all the required fields.",
                                            style: TextStyle(
                                                color: ColorConstants.purple),
                                          ),
                                          actions: <Widget>[
                                            CupertinoDialogAction(
                                              child: Text(
                                                "Ok",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  })
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
