import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login_signup/firebase/auth_service/auth_service.dart';
import 'package:provider/provider.dart';

import '../../providers/signup_screen_providers.dart';
import '../../utils/color_constant.dart';
import '../../utils/connection.dart';
import '../../utils/image_constant.dart';
import '../../utils/images/images.dart';
import '../../utils/strings/app_string.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/form_fields.dart';
import '../login/login_page.dart';

String dropdownvalue = "";

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();

  // TextEditingController nameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController confirmPasswordController = TextEditingController();

  bool _isHidden = true;

  void passwordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  var options = [
    'Buyer',
    'Seller',
  ];
  var _currentItemSelected = "Buyer";
  var roll = 'Buyer';
  // final formkey = GlobalKey<FormState>();
  late StreamSubscription subscription;
  String? dropdownvalue;
  final databaseReference = FirebaseDatabase.instance.ref();
  // List of items in our dropdown menu
  var items = [
    'Buyer',
    'Seller',
  ];

  @override
  void dispose() {
    subscription.cancel();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // subscription =
    //     Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);
  }

  //Text Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void handleSignError(FirebaseAuthException e) {
    String messageToDisplay;
    switch (e.code) {
      case "email-already-in-use":
        messageToDisplay = "This Email is already in use";
        break;

      case "invalid-email":
        messageToDisplay = "This Email you entered is Invalid";
        break;

      case "operation-not-allowed":
        messageToDisplay = "This operation is not allowed";
        break;

      case "weak-password":
        messageToDisplay = "This password you entered is too weak";
        break;

      default:
        messageToDisplay = "An Unknown Error Occurred";
        break;
    }
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
                title: Text(
                  "Sign Up Failed",
                  style: TextStyle(color: Colors.black),
                ),
                content: Text(messageToDisplay,
                    style: TextStyle(color: ColorConstants.purple)),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      "Ok",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  )
                ]));
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    return Scaffold(
      backgroundColor: ColorConstants.purple,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 25.w, top: 15.h),

                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 22.sp,
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(left: 40.w),
                child: Image(
                    height: 22.h,
                    width: 22.w,
                    image: AssetImage(
                      ImageConstant.ellipse,
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 110.w, right: 20.w),
                child: Image(image: AssetImage(ImageConstant.ellipse1)),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.w, bottom: 7.h),
            child: Text(
              "Create\n             Account",
              style: TextStyle(
                fontSize: 23.sp,
                fontWeight: FontWeight.w400,
                color: ColorConstants.white,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: Get.width * 100,
              child: Card(
                surfaceTintColor: Colors.white,
                color: ColorConstants.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 15.h, right: 25.w, left: 25.w),
                  child: SingleChildScrollView(
                    child: Consumer<SingUpPageProviders>(
                      builder: (context, provider, child) {
                        return Form(
                          key: formKey,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Register as New User",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              form_fields(
                                onChanged: (p0) {
                                  provider.nameValidation(p0);
                                },
                                onclick: () {},
                                secure: false,
                                maxlines: 1,
                                fieldtext: "",
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                hinttext: "Enter Your name",
                                icon: Icons.person,
                                label: "Name",
                                controller: nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  // Additional validation logic can be added here
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    provider.namemessage.toString(),
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                        color: (provider.nameisElegible == true)
                                            ? Colors.green
                                            : Colors.red),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              form_fields(
                                onChanged: (p0) {
                                  provider.emailValidation(p0);
                                },
                                onclick: () {},
                                maxlines: 1,
                                secure: false,
                                fieldtext: "",
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                hinttext: "Enter Your email",
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
                              SizedBox(
                                height: 3.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    provider.emailmessage.toString(),
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: (provider.emailisElegible == true)
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              form_fields(
                                onChanged: (p0) {
                                  provider.passswordValidation(p0);
                                },
                                onclick: () {
                                  passwordView();
                                },
                                fieldtext:
                                    (_isHidden == true) ? 'show' : 'hide',
                                secure: _isHidden,
                                icon: Icons.password_outlined,
                                label: "Password",
                                maxlines: 1,
                                hinttext: "Enter Your password",
                                controller: passwordController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.visiblePassword,
                                validator: ((value) {
                                  if (value!.isEmpty) {
                                    return AppTexts.passwordEmpty;
                                  } else if (value.length < 8) {
                                    return AppTexts.passwordInvalid;
                                  } else {
                                    return null;
                                  }
                                }),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    provider.passwordmessage.toString(),
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color:
                                          (provider.passwordisElegible == true)
                                              ? Colors.green
                                              : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              form_fields(
                                onChanged: (p0) {
                                  provider.confirmpasswordValidation(p0);
                                },
                                onclick: () {},
                                secure: _isHidden,
                                fieldtext: "",
                                icon: Icons.password_outlined,
                                label: "Confirm Password",
                                hinttext: "Confirm password",
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.visiblePassword,
                                maxlines: 1,
                                controller: confirmPasswordController,
                                validator: ((value) {
                                  if (value!.isEmpty) {
                                    return AppTexts.passwordEmpty;
                                  }
                                  if (passwordController.text !=
                                      confirmPasswordController.text) {
                                    passwordController.clear();
                                    confirmPasswordController.clear();
                                    return "Password Do Not Match";
                                  }
                                }),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    provider.confirmpasswordmessage.toString(),
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color:
                                          (provider.cofirmpasswordisElegible ==
                                                  true)
                                              ? Colors.green
                                              : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              // DropdownButton<String>(
                              //   dropdownColor: ColorConstants.grey,
                              //   isDense: false,
                              //   isExpanded: true,
                              //   iconEnabledColor: ColorConstants.black,
                              //   focusColor: Colors.grey,
                              //   items: options.map((String dropDownStringItem) {
                              //     return DropdownMenuItem<String>(
                              //       value: dropDownStringItem,
                              //       child: Text(
                              //         dropDownStringItem,
                              //         style: TextStyle(
                              //           color: ColorConstants.black,
                              //         ),
                              //       ),
                              //     );
                              //   }).toList(),
                              //   onChanged: (newValueSelected) {
                              //     setState(() {
                              //       _currentItemSelected = newValueSelected!;
                              //       roll = newValueSelected;
                              //     });
                              //   },
                              //   value: _currentItemSelected,
                              // ),
                              DropdownButtonFormField(
                                iconEnabledColor: ColorConstants.black,

                                hint: Text(
                                  "Select User Type",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13.sp,
                                  ),
                                ),
                                // Initial Value
                                value: dropdownvalue,
                                // Down Arrow Icon
                                icon: Icon(Icons.keyboard_arrow_down,size: 22.sp,),

                                // Array list of items
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                          color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                                validator: (value) {
                                  if (value == null)
                                    return "Please Select User Type";

                                  print(dropdownvalue);
                                  return null;
                                },
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                    // print(dropdownvalue);
                                  });
                                },
                              ),

                              SizedBox(
                                height: 20.h,
                              ),
                              custom_button(
                                  function: () async {
                                    if (formKey.currentState!.validate()) {
                                      try {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                clipBehavior: Clip.none,
                                                title: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color:
                                                        ColorConstants.purple,
                                                  ),
                                                ),
                                              );
                                            });

                                        await showDialog(
                                            context: context,
                                            builder: (context) =>
                                                CupertinoAlertDialog(
                                                  title: Text(
                                                    "Sign Up Succeeded",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  content: Text(
                                                      "Your Account Is Created, You Can LogIn Now",
                                                      style: TextStyle(
                                                          color: ColorConstants
                                                              .purple)),
                                                  actions: <Widget>[
                                                    CupertinoDialogAction(
                                                      child: Text(
                                                        "Ok",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                ));
                                        Navigator.of(context).pop();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage()));
                                      } on FirebaseAuthException catch (e) {
                                        // final result = await Connectivity().checkConnectivity();showConnectivitySnackBar(result);
                                        handleSignError(e);
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
                                  },
                                  label: 'Register',
                                  backgroundcolor: ColorConstants.purple,
                                  textcolor: ColorConstants.white),
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already a Member?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Get.back();

                                    },
                                    child: Text(
                                      " Login",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Padding(
          //   padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 20,right: MediaQuery.of(context).size.width / 20,top: MediaQuery.of(context).size.height / 120,bottom: MediaQuery.of(context).size.height / 41),
          //   child: Form(
          //     // key: formkey,
          //     //Columns For Text Fields
          //     child: Column(
          //       children: [
          //
          //         //UserName TextF
          //         //Space After UserName TextField
          //         //SignUp Button
          //         SizedBox(
          //             width: MediaQuery.of(context).size.width / 1.11,
          //             height: MediaQuery.of(context).size.height / 18.23,
          //             child: ElevatedButton(
          //                 onPressed: ()  async {
          //                   if (formkey.currentState!.validate()) {
          //                     try{
          //                       showDialog(context: context, builder: (context){
          //                         return AlertDialog(
          //                           backgroundColor: Colors.transparent,
          //                           clipBehavior: Clip.none,
          //                           title: Center(
          //                             child: CircularProgressIndicator(
          //                               color: Colors.deepOrange,
          //                             ),
          //                           ),
          //                         );
          //                       });
          //                       await FirebaseAuth.instance.createUserWithEmailAndPassword(
          //                           email: emailController.text,
          //                           password: passwordController.text);
          //                       await FirebaseFirestore.instance.collection('Users').add({
          //                         'email': emailController.text,
          //                         'password': passwordController.text,
          //                         'uid': authService.currentUser!.uid,
          //                         'role': dropdownvalue,
          //                         'admin':dropdownvalue == 'Admin'? true : false,
          //                         'restaurant':dropdownvalue == 'Restaurant'? true : false,
          //                         'user':dropdownvalue == 'User'? true : false,
          //                         'rider':dropdownvalue == 'Rider'? true : false,
          //                         // 'adminRequest': dropdownvalue == 'Admin' ? 'Pending':,
          //                       });
          //                       if(dropdownvalue == 'Admin'){
          //                         await FirebaseFirestore.instance.collection('Admin').doc(authService.currentUser!.uid).set({
          //                           'adminUid': authService.currentUser!.uid,
          //                           'adminEmail': authService.currentUser!.email
          //                         });
          //                       }
          //                       if(dropdownvalue == 'Rider'){
          //                         await FirebaseFirestore.instance.collection('Rider').doc(authService.currentUser!.uid).set({
          //                           'adminUid': authService.currentUser!.uid,
          //                           'email': authService.currentUser!.email
          //                         });
          //                       }
          //                       await showDialog(context: context, builder: (context) => AlertDialog(
          //                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          //                         title: Column(
          //                           children: <Widget>[
          //                             Text("Sign Up Succeeded",style: TextStyle(color: Colors.black),),
          //                           ],
          //                         ),
          //                         content: Text("Your Account Is Created, You Can LogIn Now",style: TextStyle(color: Colors.deepOrange)),
          //                         actions: <Widget>[
          //                           CupertinoDialogAction(
          //                             child: Text("Ok",style: TextStyle(color: Colors.black),),
          //                             onPressed: () {
          //                               Navigator.pop(context);
          //                               Navigator.pop(context);
          //                               },),
          //                         ],
          //                        ));
          //                       Navigator.of(context).pop();
          //                       Navigator.push(
          //                           context,
          //                           MaterialPageRoute(builder: (context) => const LoginPage()));
          //
          //                     }on FirebaseAuthException catch (e){
          //                       final result = await Connectivity().checkConnectivity();
          //                       showConnectivitySnackBar(result);
          //                       handleSignError (e);
          //
          //                     }
          //
          //                   }
          //                 },
          //                 style: ButtonStyle(
          //                   backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
          //                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //                       RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(10.0),
          //                       )),
          //                 ),
          //                 child: Text(AppTexts.signUp,style: TextStyle(
          //                     fontWeight: FontWeight.w600,
          //                     color: Colors.white,
          //                     fontSize: MediaQuery.of(context).size.width / 23,
          //                     height: MediaQuery.of(context).size.height / 631.2,),))),
          //         //Space Before SigUp Button
          //         SizedBox(
          //           height: MediaQuery.of(context).size.height / 80,
          //         ),
          //         //Already Account and Login
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             //Already Account Text
          //             Text(
          //               AppTexts.alreadyAccount,style: TextStyle(fontSize: MediaQuery.of(context).size.width / 25,),
          //             ),
          //             //Login Text Button
          //             InkWell(
          //               onTap: () async {
          //                 final result = await Connectivity().checkConnectivity();
          //                 showConnectivitySnackBar(result);
          //                 Navigator.push(
          //                     context,
          //                     MaterialPageRoute(builder: (context) => const LoginPage()));
          //               },
          //               child: Text(AppTexts.loginAccount,style: TextStyle(fontSize: MediaQuery.of(context).size.width / 25,color: Colors.deepOrange)
          //               ),
          //             )],
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  // void showConnectivitySnackBar(ConnectivityResult result) {
  //   final hasInternet = result != ConnectivityResult.none;
  //   final message =
  //       hasInternet ? 'You have ${result.toString()}' : 'You have no internet';
  //   final color = hasInternet ? Colors.green : Colors.red;
  //
  //   Utils.showTopSnackBar(context, message, color);
  // }
}
