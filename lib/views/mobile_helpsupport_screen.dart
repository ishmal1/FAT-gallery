import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/admin_textfield_screen.dart';
import '../../components/drawer_view.dart';
import '../../firebase/firestore_fetch_data/fetch_user_data.dart';
import '../../utils/color_constant.dart';
import '../../utils/image_constant.dart';
import '../../widgets/custom_button.dart';
import '../components/text_fields.dart';

class mobilehelpsupport_screen extends StatefulWidget {
  const mobilehelpsupport_screen({Key? key}) : super(key: key);

  @override
  State<mobilehelpsupport_screen> createState() => _mobilehelpsupport_screenState();
}

class _mobilehelpsupport_screenState extends State<mobilehelpsupport_screen> {
  final formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  void _submitForm() {
    if (formKey.currentState!.validate()) {

      setState(() {
      _isLoading = true;
    });

    // Simulating a delay of 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text("Thanks for contacting us",
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500)),
          content: Text("We will entertain your query in 12 hours",
              style: TextStyle(color: ColorConstants.purple,fontSize: 12.sp)),
          actions: <Widget>[
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


  final TextEditingController nameController = TextEditingController();
  final TextEditingController problemController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Customer Support",
          style: TextStyle(
            color: ColorConstants.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorConstants.grey,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: ColorConstants.black,
        ),
      ),

      backgroundColor: ColorConstants.grey,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w,right: 20.w),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, top: 10.h),
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.help_outline,
                            size: 22.sp,
                            color: ColorConstants.purple,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "Help & Support",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
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
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      TextFormFieldWidget(
                        fillColor: Colors.white,
                        textInputType: TextInputType.text,
                        actionKeyboard: TextInputAction.next,
                        controller: nameController,
                        hintText: "faizanjutt480@gmail.com",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          // Additional validation logic can be added here
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
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
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      TextFormFieldWidget(
                        fillColor: Colors.white,
                        textInputType: TextInputType.text,
                        actionKeyboard: TextInputAction.next,
                        controller: problemController,
                        hintText: "Enter your problem here",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your problem';
                          }
                          // Additional validation logic can be added here
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
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
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      TextFormFieldWidget(
                        maxLines: 10,
                        fillColor: Colors.white,
                        textInputType: TextInputType.text,
                        actionKeyboard: TextInputAction.next,
                        controller: messageController,
                        hintText: "Enter your problem here",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter in detail your issue';
                          }
                          // Additional validation logic can be added here
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // SizedBox(
                  //     width: 100.w,
                  //     child: custom_button(
                  //         label: "Submit",
                  //         backgroundcolor: ColorConstants.purple,
                  //         textcolor: ColorConstants.white,
                  //         function: (){},),),
                  SizedBox(
                    width: 330.w,
                    height: 35.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.purple,
                        minimumSize: Size(260.w, 40.h),
                        maximumSize: Size(260.w, 40.h),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        elevation: 30,
                      ),
                      onPressed: _isLoading ? null : _submitForm,
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Text(
                        "Submit",
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 14.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
