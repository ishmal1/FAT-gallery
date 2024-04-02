import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:login_signup/views/Seller%20Screens/seller_Dashboard_screen.dart';
import 'package:login_signup/views/forgot_password.dart';
import 'package:provider/provider.dart';
import '../../firebase/social_media_buttons.dart';
import '../../controller/auth_controller.dart';
import '../../providers/login_screen_providers.dart';
import '../../utils/color_constant.dart';
import '../../utils/image_constant.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/form_fields.dart';
import '../signup/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late StreamSubscription subscription;
  late final Timer timer;
  bool isHidden = true;

  bool check = false;
  void passwordView() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  final AuthController authController = AuthController();
  final formKey = GlobalKey<FormState>();


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  //Images SlideShow



  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   subscription =
  //       Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);
  //   timer = Timer.periodic(const Duration(seconds: 5), (timer) {
  //     setState(() => _index++);
  //   });
  // }

  Future signIn()async{
    if (formKey.currentState!.validate()) {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home_screen()));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Seller_dashbaord()));


  }else {
      // Show validation error message
      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(

          title: Text(
            "Validation Error",
            style: TextStyle(color: Colors.black),
          ),
          content: Text(
            "Please fill in all the required fields.",
            style: TextStyle(color: ColorConstants.purple),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.purple,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 60.w,right: 25.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(
                    height: 22.h,
                    width: 22.w,
                    image: AssetImage(ImageConstant.ellipse,)),
                Image(image: AssetImage(ImageConstant.ellipse1)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.w, top: 7.h,),
            child: Text(
              "Welcome\nBack",
              style: TextStyle(
                fontSize: 30.sp,
                color: ColorConstants.white,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 75.w,bottom: 25.h),
            alignment: Alignment.centerRight,
            child: Image(height: 30.h,width: 30.w,
                image: AssetImage(ImageConstant.ellipse2)),
          ),
          Expanded(
            child: SizedBox(
              child: Card(
                surfaceTintColor: Colors.white,
                color: ColorConstants.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, right: 30, left: 30,),
                  child: Consumer<LoginPageProviders>(
                    builder: (context, provider, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                           Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                           SizedBox(
                            height: 25.h,
                          ),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                form_fields(
                                  onChanged: (p0) {
                                    provider.emailValidation(p0);
                                  },
                                  onclick: () {},
                                  textInputAction: TextInputAction.next,
                                  secure: false,
                                  maxlines: 1,
                                  fieldtext: "",
                                  keyboardType: TextInputType.emailAddress,
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
                                        color: (provider.emailElegible == true)
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                form_fields(
                                  onChanged: (p0) {
                                    provider.passswordValidation(p0);
                                  },
                                  onclick: () {
                                    passwordView();
                                  },
                                  secure: isHidden,
                                  maxlines: 1,
                                  textInputAction: TextInputAction.done,
                                  icon: Icons.lock_outline_rounded,
                                  keyboardType: TextInputType.visiblePassword,
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
                                        color: (provider.passwordElegible == true)
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          GestureDetector(
                            onTap: (){
                              Get.to(const forgot_password_screen());

                            },
                            child: Text(
                              "Forgot Passcode?",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.purple,
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 25.h),
                              child: Column(
                                children: [
                                  custom_button(
                                      label: 'Login',
                                      backgroundcolor: ColorConstants.purple,
                                      textcolor: ColorConstants.white,
                                      function: () {
                                        signIn();

                                      }),
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  const SocialMediaButtons(),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Get.to( SignUp());

                                    },
                                    child: Text(
                                      "Create Account ?",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: ColorConstants.purple,
                                      ),
                                    ),
                                  ),
                                ],
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
          ),
// Main Text Food MEnu
//         Form(
//             key: formKey,
//             child: Column(
//               children: <Widget>[
//                 //Padding For email TextField
//                 Padding(
//                   padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 20.571, right: MediaQuery.of(context).size.width / 20.571, top: MediaQuery.of(context).size.height / 41.02,),
//                   //username TextField
//                   child: TextFormField(
//                     autofocus: false,
//                     controller: emailController,
//                     keyboardType: TextInputType.emailAddress ,
//                     // validator: (){},
//                     textInputAction: TextInputAction.next,
//                     obscureText: false,
//                     style: const TextStyle(color: Colors.black,),
//                     decoration: InputDecoration(
//                       focusedErrorBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.deepOrange,width: MediaQuery.of(context).size.width /200,),
//                           borderRadius: BorderRadius.circular(10)
//                       ),
//                       errorBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.deepOrange,width: MediaQuery.of(context).size.width /200,),
//                           borderRadius: BorderRadius.circular(10)
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.deepOrange,width: MediaQuery.of(context).size.width /200,),
//                           borderRadius: BorderRadius.circular(10)
//                       ),
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.zero,
//                         child: Icon(
//                           Icons.email_rounded,
//                           size: MediaQuery.of(context).size.width /20.55,
//                           color: Colors.black54,
//                         ),
//                       ),
//                       filled: true,
//                       fillColor: Colors.white.withOpacity(0.9),
//                       focusColor: Colors.black,
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(
//                               color: Colors.deepOrange, width: MediaQuery.of(context).size.width /200)),
//                       hintStyle:
//                            TextStyle(fontSize: MediaQuery.of(context).size.width / 29.38, color: Colors.black54,),
//                       hintText: AppTexts.emailPhoneEnter,
//                     ),
//                     validator: ((value) {
//                       if (value!.isEmpty) {
//                         return AppTexts.emailEmpty;
//                       } else if (value.endsWith(AppTexts.emailGmail) ||
//                           (value.endsWith(AppTexts.emailYahoo) ||
//                               (value.endsWith(AppTexts.emailOutlook)))) {
//                         if (value.contains(' ')) {
//                           return AppTexts.spaceText;
//                         }
//                         return null;
//                       } else {
//                         return AppTexts.emailInvalid;
//                       }
//                     }
//                     ),
//                   ),
//                 ),
//                 //Padding For Password TextField
//                 Padding(
//                   padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 20.571, right: MediaQuery.of(context).size.width / 20.571, top: MediaQuery.of(context).size.height / 41.02,),
//                   //Password text field
//                   child: TextFormField(
//                     autofocus: false,
//                     controller: passwordController,
//                     // validator: (){},
//                     textInputAction: TextInputAction.done,
//                     obscureText: true,
//                     style: const TextStyle(color: Colors.black),
//                     decoration: InputDecoration(
//                       focusedErrorBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.deepOrange,width: MediaQuery.of(context).size.width /200,),
//                           borderRadius: BorderRadius.circular(10)
//                       ),
//                       errorBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.deepOrange,width: MediaQuery.of(context).size.width /200,),
//                           borderRadius: BorderRadius.circular(10)
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.deepOrange,width: MediaQuery.of(context).size.width /200,),
//                           borderRadius: BorderRadius.circular(10)
//                       ),
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.zero,
//                         child: Icon(
//                           Icons.password_rounded,
//                           size: MediaQuery.of(context).size.width /20.55,
//                           color: Colors.black54,
//                         ),
//                       ),
//                       filled: true,
//
//                       fillColor: Colors.white.withOpacity(0.9),
//                       focusColor: Colors.black,
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(
//                               color: Colors.deepOrange, width: MediaQuery.of(context).size.width /200,)
//                       ),
//                       hintStyle:
//                       TextStyle(fontSize: MediaQuery.of(context).size.width / 29.38, color: Colors.black54,),
//                       hintText: AppTexts.passwordEnter,
//                     ),
//                     validator: ((value) {
//                       if (value!.isEmpty) {
//                         return AppTexts.passwordEmpty;
//                       } else if (value.length < 8 ) {
//                         return AppTexts.passwordInvalid;
//                       } else {
//                         return null;
//                       }
//                     }
//                     ),
//                   ),
//                 ),
//
//                 //Padding for forgot password
//                 Padding(
//                   padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 1.7,),
//                   //forgot password Button
//                   child: TextButton(
//                     onPressed: () async {
//                       final result = await Connectivity().checkConnectivity();
//                       showConnectivitySnackBar(result);
//                     },
//                     child: Text(AppTexts.forgot,style: TextStyle(color: Colors.red,fontSize: MediaQuery.of(context).size.width / 29.38,),),
//                   ),
//                 ),
//
//                 //LOGIN BUTTON
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width / 1.11,
//                   height: MediaQuery.of(context).size.height / 18.23,
//                   child: ElevatedButton(
//                     //login button
//                       onPressed: () async {
//                         if (formKey.currentState!.validate()) {
//                           signIn();
//
//                         }
//
//                       },
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
//                         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         )),
//                       ),
//                       child: Text(
//                         AppTexts.login,
//                         style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                             fontSize: MediaQuery.of(context).size.width / 23,
//                             height: MediaQuery.of(context).size.height / 631.2,),
//                       )),
//                 ),
//                 //Row for Create Account and SignUp with
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     //Create Account Button
//                     TextButton(
//                       onPressed: () async {
//                         final result = await Connectivity().checkConnectivity();
//                         showConnectivitySnackBar(result);
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => SignUp()));
//                       },
//                       child: Text(AppTexts.createAccount,style: TextStyle(color: Colors.deepOrange,fontSize: MediaQuery.of(context).size.width / 25,),),
//                     ),
//                     //Width Before Text
//                     SizedBox(
//                         width: MediaQuery.of(context).size.width / 41.1,),
//                     //Text
//                     Text("or",style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.width / 29.38,)),
//                     //Width After Text
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width / 41.1,),
//                     //Sign Up with Button
//                     TextButton(
//                       onPressed: () async {
//                         final result = await Connectivity().checkConnectivity();
//                         showConnectivitySnackBar(result);
//                         showModalBottomSheet(context: context,
//                             isScrollControlled: true,
//                             backgroundColor: Colors.grey.shade100,
//                             shape: const RoundedRectangleBorder(
//                                 borderRadius: BorderRadiusDirectional.vertical(
//                                   top: Radius.circular(20),
//                                 )
//                             ),
//                             //Bottom Sheet
//                             builder: (context) => DraggableScrollableSheet(
//                                 initialChildSize: 0.4,
//                                 maxChildSize: 0.9,
//                                 minChildSize: 0.32,
//                                 expand: false,
//                                 builder: (context, scrollController) {
//                                   return SingleChildScrollView(
//                                     controller: scrollController,
//                                     child: Stack(
//                                       alignment: AlignmentDirectional.topCenter,
//                                       children: [
//                                         SizedBox(height: MediaQuery.of(context).size.height / 82.05,),
//                                         Container(
//                                           margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 41.02),
//                                           child: Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: <Widget>[
//                                               Center(child: LargeText(text: AppTexts.loginSignIn,size: MediaQuery.of(context).size.width / 20.5,fontWeight: FontWeight.w700,)),
//                                               SizedBox(height: MediaQuery.of(context).size.height / 82),
//                                               SignInButton(
//                                                 onTap: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                                 iconPath: AppImages.phoneImg,
//                                                 textLabel: AppTexts.signUpWithP,
//                                                 backgroundColor: Colors.white,
//                                                 elevation: 5.0,
//                                                 borderColor: Colors.grey,
//                                               ),
//                                               SizedBox(
//                                                 height: MediaQuery.of(context).size.height / 50),
//                                               Center(
//                                                 child: Text(
//                                                   '                                or                                 ',
//                                                   style: TextStyle(fontSize: MediaQuery.of(context).size.width / 22.85),),
//                                                 ),
//                                               SizedBox(
//                                                 height: MediaQuery.of(context).size.height / 50),
//                                               SignInButton(
//                                                 onTap: () {},
//                                                 iconPath: AppImages.googleImg,
//                                                 textLabel: AppTexts.signUpWithG,
//                                                 backgroundColor: Colors.grey.shade300,
//                                                 elevation: 5.0,
//                                               ),
//                                               SizedBox(
//                                                 height: MediaQuery.of(context).size.height / 58.6),
//                                               SignInButton(
//                                                 onTap: () {},
//                                                 iconPath: AppImages.facebookImg,
//                                                 textLabel: AppTexts.signUpWithF,
//                                                 backgroundColor: Colors.blue.shade300,
//                                                 elevation: 5.0,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 })
//                         );
//                       },
//                       child: Text('Sign Up With',style: TextStyle(color: Colors.deepOrange,fontSize: MediaQuery.of(context).size.width / 25),)
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           )
        ],
      ),
    );
  }
  // void showConnectivitySnackBar(ConnectivityResult result) {
  //   final hasInternet = result != ConnectivityResult.none;
  //   final message = hasInternet
  //       ? 'You have ${result.toString()}'
  //       : 'You have no internet';
  //   final color = hasInternet ? Colors.green : Colors.red;
  //
  //   Utils.showTopSnackBar(context, message, color);
  // }
}
