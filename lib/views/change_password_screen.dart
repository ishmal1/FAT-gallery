import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/color_constant.dart';
import '../../../utils/image_constant.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/form_fields.dart';
import '../components/text_fields.dart';
import '../utils/strings/app_string.dart';


class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: ColorConstants.purple,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: ColorConstants.white),
          elevation: 0,
          backgroundColor: ColorConstants.purple,
          title: Text(
            "Forgot Password",
            style: TextStyle(
                color: ColorConstants.white,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
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
                      padding:
                      const EdgeInsets.only( right: 30, left: 30),
                      child: Column(
                        children: [

                          const SizedBox(
                            width: 50,
                            child: Divider(
                              color: Color(0xff5956E9),
                              thickness: 3,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "New Password",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 210.w,
                            height: 40.h,
                            child: Column(
                              children: const [
                                Text(
                                  "Enter your new password",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "to continue.",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          TextFormFieldWidget(
                            obscureText: true,
                            controller: passwordController,
                            textInputType: TextInputType.text,
                            actionKeyboard: TextInputAction.next,
                            hintText: "Enter New Password",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon:  Icon(Icons.visibility_off),
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
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormFieldWidget(
                            obscureText: true,
                            controller: confirmPasswordController,
                            textInputType: TextInputType.text,
                            actionKeyboard: TextInputAction.done,
                            hintText: "Confirm New Password",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: const Icon(Icons.visibility_off),
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return AppTexts.passwordEmpty;
                              } if(passwordController.text != confirmPasswordController.text){
                                passwordController.clear();
                                confirmPasswordController.clear();
                                return "Password Do Not Match";
                              }
                            }
                            ),

                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          custom_button(
                            label: 'Submit',
                            backgroundcolor: ColorConstants.purple,
                            textcolor: ColorConstants.white,
                            function: () async {

                            },
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
      // child: Scaffold(
      //   resizeToAvoidBottomInset: false,
      //   body: Container(
      //       width: double.infinity,
      //       height: double.infinity,
      //       decoration: const BoxDecoration(
      //           gradient: LinearGradient(
      //               begin: Alignment.topCenter,
      //               end: Alignment.bottomCenter,
      //               colors: [
      //                 Color(0xFF40247A),
      //                 Color.fromRGBO(94, 37, 99, 0.78)
      //
      //               ]
      //           )
      //       ),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           InkWell(
      //             onTap: (){
      //               Navigator.pop(context);
      //             },
      //             child: Padding(
      //               padding: EdgeInsets.only(top: 40.h,left: 30.w),
      //               child: Icon(Icons.arrow_back,color: Colors.white,),
      //             ),
      //           ),
      //           SizedBox(height: 30.h ,),
      //           Center(child: Text("BUFFER",style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600,color: Colors.white ),)),
      //           SizedBox(height: 30.h,),
      //           Center(child: Text("Please enter your new password",style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400,color: Colors.white ),)),
      //           SizedBox(height: 20.h,),
      //           Padding(
      //             padding: EdgeInsets.only(left: 30.w),
      //             child: Center(
      //               child: Container(
      //                 height: 200.h,
      //                 width: 200.w,
      //                 decoration: BoxDecoration(
      //                     image: DecorationImage(
      //                         image: AssetImage("")
      //                     )
      //                 ),
      //               ),
      //             ),
      //           ),
      //           SizedBox(height: 10.h,),
      //           Center(
      //             child: Container(
      //               width: 300.w,
      //               padding: EdgeInsets.only(top: 5.h),
      //               child: TextFormField(
      //                 textAlign: TextAlign.center,
      //                 textInputAction: TextInputAction.next,
      //                 keyboardType: TextInputType.visiblePassword,
      //                 obscureText: true,
      //                 decoration: InputDecoration(
      //                   hintText:"Enter Password",
      //                   hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 14.sp),
      //                   prefixIcon: Padding(
      //                     padding: EdgeInsets.only(left: 10.w),
      //                     child: Icon(Icons.lock,color: ColorConstants.purple,),
      //                   ),
      //                   suffixIcon: Padding(
      //                     padding: EdgeInsets.only(right: 10.w),
      //                     child: const Icon(Icons.visibility_off,color: Colors.black,),
      //                   ),
      //                   filled: true,
      //                   fillColor: ColorConstants.purple,
      //                   focusedBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(20),
      //                       borderSide: BorderSide(
      //                         color: Colors.white54,
      //                         width:2.w,
      //                       )
      //                   ),
      //                   enabledBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(20),
      //                       borderSide:BorderSide(
      //                         color: Colors.black54,
      //                       )
      //                   ),
      //                   disabledBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(20),
      //                       borderSide:BorderSide(
      //                         color: Colors.white54,
      //                       )
      //                   ),
      //                 ),
      //                 style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 14.sp),
      //               ),
      //             ),
      //           ),
      //           SizedBox(height: 10.h,),
      //           Center(
      //             child: Container(
      //               width: 300.w,
      //               padding: EdgeInsets.only(top: 5.h),
      //               child: TextFormField(
      //                 textAlign: TextAlign.center,
      //                 textInputAction: TextInputAction.done,
      //                 keyboardType: TextInputType.visiblePassword,
      //                 obscureText: true,
      //                 decoration: InputDecoration(
      //                   hintText:"Re-enter Password",
      //                   hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 14.sp),
      //                   prefixIcon: Padding(
      //                     padding: EdgeInsets.only(left: 10.w),
      //                     child: Icon(Icons.lock,color: Colors.black,),
      //                   ),
      //                   suffixIcon: Padding(
      //                     padding: EdgeInsets.only(right: 10.w),
      //                     child: const Icon(Icons.visibility_off,color: Colors.black,),
      //                   ),
      //                   filled: true,
      //                   fillColor: ColorConstants.purple,
      //                   focusedBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(20),
      //                       borderSide: BorderSide(
      //                         color: Colors.white54,
      //                         width:2.w,
      //                       )
      //                   ),
      //                   enabledBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(20),
      //                       borderSide:BorderSide(
      //                         color: Colors.black54,
      //                       )
      //                   ),
      //                   disabledBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(20),
      //                       borderSide:BorderSide(
      //                         color: Colors.white54,
      //                       )
      //                   ),
      //                 ),
      //                 style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 14.sp),
      //               ),
      //             ),
      //           ),
      //           SizedBox(height: 40.h,),
      //           InkWell(
      //             onTap: (){
      //               // Navigator.pop(context);
      //             },
      //             child: Center(
      //               child: Container(
      //                 width: 170.w,
      //                 height: 45.h,
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(25),
      //                   color:  ColorConstants.purple,
      //                 ),
      //                 child: Center(child: Text("Continue",style: TextStyle(color: Colors.black,fontSize: 16.sp,fontWeight: FontWeight.w800),)),
      //               ),
      //             ),
      //           ),
      //         ],
      //       )
      //
      //   ),
      //
      // ),
    );
  }
}
