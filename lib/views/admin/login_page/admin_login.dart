
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login_signup/components/admin_form_fields.dart';
import 'package:login_signup/views/Seller%20Screens/seller_Dashboard_screen.dart';
import 'package:login_signup/views/admin/admin_home_screen/adminhome_screen.dart';
import 'package:provider/provider.dart';

import '../../../../providers/login_screen_providers.dart';
import '../../../../utils/color_constant.dart';
import '../../../../utils/image_constant.dart';
import '../../../components/admin_custom_button.dart';
import '../../../firebase/auth_service/auth_service.dart';
import '../../../firebase/firestore_fetch_data/fetch_user_data.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/form_fields.dart';

class adminlogin_screen extends StatefulWidget {
  const adminlogin_screen({Key? key}) : super(key: key);

  @override
  State<adminlogin_screen> createState() => _adminlogin_screenState();
}

class _adminlogin_screenState extends State<adminlogin_screen> {
  final formKey = GlobalKey<FormState>();


  void handleLoginError(FirebaseAuthException e){
    String messageToDisplay;
    switch(e.code){
      case 'user-not-found':
        messageToDisplay='No user found for that email.';
        emailController.clear();
        passwordController.clear();
        break;

      case "invalid-email":
        messageToDisplay="This Email you entered is Invalid.";
        emailController.clear();
        break;

      case "wrong-password":
        messageToDisplay="Wrong password provided for that user.";
        passwordController.clear();
        break;

      default :
        messageToDisplay="No Internet Connection.";
        break;

    }
    showDialog(context: context, builder: (context)=> CupertinoAlertDialog(

      title: Text("Log In Failed",style: TextStyle(color: Colors.black),),
      content: Text(messageToDisplay,style: TextStyle(color: ColorConstants.purple)),
      actions: <Widget>[

        CupertinoDialogAction(
          child: Text("Ok",style: TextStyle(color: Colors.black),),
          onPressed: () {
            Navigator.of(context).pop();
          },),
      ],
      // title: const Text("Log In Failed",style: TextStyle(color: Colors.black)),
      // content: Text(messageToDisplay,style: TextStyle(color: Colors.deepOrange)),
      // actions: [TextButton( onPressed: () {Navigator.of(context).pop();},
      //   child: const Text("Ok",style: TextStyle(color: Colors.black)),)],
    ));
  }

  Future signIn()async{
    if (formKey.currentState!.validate()) {
    try {
      showDialog(context: context, builder: (context)=> AlertDialog(
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.none,

        title: Center(
          child: CircularProgressIndicator(
            color: ColorConstants.purple,
          ),
        ),
      )
      );


        return Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => adminhome_screen()));
      // }else if (role_firestore == 'Buyer'){
      //   Navigator.of(context).pop();
      //   Navigator.of(context).pop();
      //   return Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) =>  home_screen()));
      // }else if (role_firestore == 'Seller'){
      //   Navigator.of(context).pop();
      //   Navigator.of(context).pop();
      //   return Navigator.push(context, MaterialPageRoute(builder: (context) => Seller_dashbaord()));

    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      handleLoginError (e);

    }

  }else {
      // Show validation error message
      // showDialog(
      //   context: context,
      //   builder: (context) => CupertinoAlertDialog(
      //
      //     title: Text(
      //       "Validation Error",
      //       style: TextStyle(color: Colors.black),
      //     ),
      //     content: Text(
      //       "Please fill in all the required fields.",
      //       style: TextStyle(color: ColorConstants.purple),
      //     ),
      //     actions: <Widget>[
      //       CupertinoDialogAction(
      //         child: Text(
      //           "Ok",
      //           style: TextStyle(color: Colors.black),
      //         ),
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         },
      //       ),
      //     ],
      //   ),
      // );
    }
  }

  bool isHidden = true;
  void passwordView() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
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
              height: 520.h,
              width: 300.w,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: ColorConstants.grey,
                child: Consumer<LoginPageProviders>(
                  builder: (context, provider, child) {
                    return Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            color: ColorConstants.purple,
                          ),
                          height: double.maxFinite,
                          width: 150.w,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 60.w, right: 25.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image(
                                          height: 22.h,
                                          width: 22.w,
                                          image: AssetImage(
                                            ImageConstant.ellipse,
                                          )),
                                      Image(image: AssetImage(ImageConstant.ellipse1)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 80, bottom: 30),
                                  alignment: Alignment.centerRight,
                                  child: Image(
                                      height: 32,
                                      width: 32,
                                      image: AssetImage(ImageConstant.ellipse2)),
                                ),
                                SizedBox(
                                  height: 50.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 30,
                                    top: 10,
                                  ),
                                  child: Text(
                                    "Welcome\nBack",
                                    style: TextStyle(
                                      fontSize: 60,
                                      color: ColorConstants.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50.h,
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 50.w),
                                  alignment: Alignment.centerRight,
                                  child:
                                  Image(
                                      height: 23,
                                      width: 23,
                                      image: AssetImage(ImageConstant.ellipse5)),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 80.w),
                                  alignment: Alignment.center,
                                  child:
                                  Image(
                                      width: 79,
                                      height: 79,
                                      image: AssetImage(ImageConstant.ellipse4)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.w, right: 15.w,top: 60.h,bottom: 20.h),
                          child: Form(
                            key: formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hello !",
                                    style: TextStyle(
                                      fontSize: 5.sp,
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstants.black,
                                    ),
                                  ),
                                  SizedBox(height: 1.h,),
                                  Text(
                                    "Good Morning",
                                    style: TextStyle(
                                      fontSize: 7.sp,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.purple,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 75.h,top: 20.h),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Login",
                                          style: TextStyle(
                                            fontSize: 7.sp,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstants.purple,
                                          ),
                                        ),
                                        Text(
                                          " Your Account",
                                          style: TextStyle(
                                            fontSize: 7.sp,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstants.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.h,
                                  ),
                                  SizedBox(
                                    width: 100.w,
                                    child: admin_form_fields(
                                      onChanged: (p0) {
                                        provider.emailValidation(p0);
                                      },
                                      onclick: () {},
                                      secure: false,
                                      maxlines: 1,
                                      fieldtext: "",
                                      icon: Icons.mail_outline_rounded,
                                      label: "Email",
                                      controller: emailController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter an email';
                                        }
                                        // Additional validation logic can be added here
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        provider.emailmessage.toString(),
                                        style: TextStyle(
                                          color: (provider.emailElegible == true)
                                              ? Colors.green
                                              : Colors.red,
                                            fontSize: 2.5.sp
                              
                              
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
                                  SizedBox(
                                    width: 100.w,
                                    child: admin_form_fields(
                                      onChanged: (p0) {
                                        provider.passswordValidation(p0);
                                      },
                                      onclick: () {
                                        passwordView();
                                      },
                                      secure: isHidden,
                                      maxlines: 1,
                                      icon: Icons.lock_outline_rounded,
                                      label: "Password",
                                      fieldtext: (isHidden == true) ? 'show' : 'hide',
                                      controller: passwordController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter password';
                                        }
                                        // Additional validation logic can be added here
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        provider.passwordmessage.toString(),
                                        style: TextStyle(
                                          color: (provider.passwordElegible == true)
                                              ? Colors.green
                                              : Colors.red,
                                            fontSize: 2.5.sp
                              
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  GestureDetector(
                                    onTap: (){},
                                    child: Text(
                                      "Forgot Passcode?",
                                      style: TextStyle(
                                        fontSize: 4.sp,
                                        fontWeight: FontWeight.w600,
                                        color: ColorConstants.purple,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.h,left: 55.h),
                                    child: SizedBox(
                                      width: 70.w,
                                      child: admin_custom_button(
                                          label: 'Login',
                                          backgroundcolor: ColorConstants.purple,
                                          textcolor: ColorConstants.white,
                                          function: () {
                                            signIn();
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),


                      ],
                    );
                  },
                ),
              ),
            ),
          ),

          //     Center(
          //   child: SizedBox(
          //       height: 500.h,
          //       width: 300.w,
          //       child: Card(
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10)),
          //         child: Row(
          //           children: [
          //             Container(
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.only(
          //                     topLeft: Radius.circular(10),
          //                     bottomLeft: Radius.circular(10)),
          //                 color: ColorConstants.purple,
          //               ),
          //               height: double.maxFinite,
          //               width: 150.w,
          //               child: Column(
          //                 children: [
          //                   Padding(
          //                     padding: const EdgeInsets.only(left: 65, right: 30),
          //                     child: Row(
          //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Image(
          //                             height: 25,
          //                             width: 25,
          //                             image: AssetImage(
          //                               ImageConstant.ellipse,
          //                             )),
          //                         Image(image: AssetImage(ImageConstant.ellipse1)),
          //                       ],
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: 20.h,
          //                   ),
          //                   Container(
          //                     padding: const EdgeInsets.only(right: 80, bottom: 30),
          //                     alignment: Alignment.centerRight,
          //                     child: Image(
          //                         height: 32,
          //                         width: 32,
          //                         image: AssetImage(ImageConstant.ellipse2)),
          //                   ),
          //                   SizedBox(
          //                     height: 50.h,
          //                   ),
          //                   Padding(
          //                     padding: const EdgeInsets.only(
          //                       left: 30,
          //                       top: 10,
          //                     ),
          //                     child: Text(
          //                       "Welcome\nBack",
          //                       style: TextStyle(
          //                         fontSize: 60,
          //                         color: ColorConstants.white,
          //                       ),
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: 50.h,
          //                   ),
          //                   Container(
          //                     padding: EdgeInsets.only(right: 50.w),
          //                     alignment: Alignment.centerRight,
          //                     child:
          //                         Image(
          //                           height: 23,
          //                             width: 23,
          //                             image: AssetImage(ImageConstant.ellipse5)),
          //                   ),
          //                   Container(
          //                     padding: EdgeInsets.only(right: 80.w),
          //                     alignment: Alignment.center,
          //                     child:
          //                         Image(
          //                           width: 79,
          //                             height: 79,
          //                             image: AssetImage(ImageConstant.ellipse4)),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             Padding(
          //               padding: EdgeInsets.only(left: 15.w, right: 15.w,top: 60.h),
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     "Hello !",
          //                     style: TextStyle(
          //                       fontSize: 5.sp,
          //                       fontWeight: FontWeight.w600,
          //                       color: ColorConstants.black,
          //                     ),
          //                   ),
          //                   SizedBox(height: 1.h,),
          //                   Text(
          //                     "Good Morning",
          //                     style: TextStyle(
          //                       fontSize: 7.sp,
          //                       fontWeight: FontWeight.bold,
          //                       color: ColorConstants.purple,
          //                     ),
          //                   ),
          //                   Padding(
          //                     padding: EdgeInsets.only(left: 75.h,top: 20.h),
          //                     child: Row(
          //                       children: [
          //                         Text(
          //                           "Login",
          //                           style: TextStyle(
          //                             fontSize: 7.sp,
          //                             fontWeight: FontWeight.bold,
          //                             color: ColorConstants.purple,
          //                           ),
          //                         ),
          //                         Text(
          //                           " Your Account",
          //                           style: TextStyle(
          //                             fontSize: 7.sp,
          //                             fontWeight: FontWeight.bold,
          //                             color: ColorConstants.black,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: 40.h,
          //                   ),
          //                   SizedBox(
          //                     width: 80.w,
          //                     child: form_fields(
          //                       onclick: () {},
          //                       secure: false,
          //                       maxlines: 1,
          //                       hinttext: "Enter Your Email Address",
          //                       icon: Icons.lock_outline_rounded,
          //                       label: "Email",
          //                       fieldtext: "",
          //                       controller: passwordController, onChanged: (String ) {  },
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: 40.h,
          //                   ),
          //                   SizedBox(
          //                     width: 80.w,
          //                     child: Row(
          //                       children: [
          //                         form_fields(
          //                           onChanged: (p0) {
          //                             // provider.passswordValidation(p0);
          //                           },
          //                           onclick: () {
          //                             passwordView();
          //                           },
          //                           secure: isHidden,
          //                           maxlines: 1,
          //                           icon: Icons.lock_outline_rounded,
          //                           label: "Password",
          //                           fieldtext: (isHidden == true) ? 'show' : 'hide',
          //                           controller: passwordController,
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: 10.h,
          //                   ),
          //                   TextButton(
          //                       onPressed: () {
          //                         // Get.to(const forgot_password_screen());
          //                       },
          //                       child: Text(
          //                         "Forgot Passcode?",
          //                         style: TextStyle(
          //                           fontSize: 15,
          //                           fontWeight: FontWeight.w600,
          //                           color: ColorConstants.purple,
          //                         ),
          //                       )),
          //                   Padding(
          //                     padding: EdgeInsets.only(top: 20.h,left: 55.h),
          //                     child: custom_button(
          //                         label: 'Login',
          //                         backgroundcolor: ColorConstants.purple,
          //                         textcolor: ColorConstants.white,
          //                         function: () {
          //                           Get.to( NewPage());
          //                         }),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       )),
          // )
        ]);
  }
}
