import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_signup/main.dart';
import 'package:login_signup/utils/color_constant.dart';

import '../../firebase/auth_service/auth_service.dart';
import '../../utils/strings/app_string.dart';
import '../notifications/notifications_page.dart';

class AddRestaurants extends StatefulWidget {
  const AddRestaurants({Key? key}) : super(key: key);

  @override
  State<AddRestaurants> createState() => _AddRestaurantsState();
}

class _AddRestaurantsState extends State<AddRestaurants> {

  List<DropDownValueModel> selectedValues = [];



  // void _showOrderNotification(String title, String body) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         content: Text(body),
  //         actions: [
  //           ElevatedButton(
  //             child: Text('Close'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }



  AuthService authService = AuthService();
  final formKey = GlobalKey<FormState>();
  File? _imageFile;
  final picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await picker.getImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (error) {
      print('Failed to pick image: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to pick image.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }
  }
  @override
  void dispose() {
    restaurantNameController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    sumaryController.dispose();
    super.dispose();
  }

  //Text Controllers
  final TextEditingController restaurantNameController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController sumaryController = TextEditingController();

  void handleSignError(FirebaseAuthException e) {
    String messageToDisplay;
    switch (e.code) {
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
                title: Column(
                  children: <Widget>[
                    Text(
                      "Process Failed",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                content: Text(messageToDisplay,
                    style: TextStyle(color: ColorConstants.purple,fontSize: 12.sp)),
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
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 16),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 27.4),
                        child: const Icon(Icons.arrow_back_ios_new_rounded)),
                  ),
                ),
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 82.05,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 1.h,bottom: 10.h),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Register Gallery",
                              style: TextStyle(
                                  color: ColorConstants.purple,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 200),
                            Container(
                              margin: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height / 160),
                              width: MediaQuery.of(context).size.width / 4.3,
                              height: MediaQuery.of(context).size.height / 130,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      ColorConstants.purple,
                                      ColorConstants.lightBlue
                                    ]),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 60),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 20,
                                  right:
                                      MediaQuery.of(context).size.width / 20),
                              child: TextFormField(
                                style: TextStyle(fontSize: 13.sp),
                                autofocus: false,
                                controller: restaurantNameController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorConstants.purple,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                200,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorConstants.purple,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                200,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorConstants.purple,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                200,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.zero,
                                    child: Icon(
                                      Icons.add_business_rounded,
                                      size: MediaQuery.of(context).size.width /
                                          20.55,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  label: Text(
                                    "Gallery Name",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: ColorConstants.purple,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                200,
                                      )),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppTexts.restaurantNameEmpty;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            //Space After UserName TextField
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 60),
                            //Phone TextField
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 20,
                                  right:
                                      MediaQuery.of(context).size.width / 20),
                              child: TextFormField(
                                style: TextStyle(fontSize: 13.sp),

                                autofocus: false,
                                controller: phoneNumberController,
                                keyboardType: TextInputType.phone,
                                // validator: (){},
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorConstants.purple,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                200,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorConstants.purple,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                200,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorConstants.purple,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                200,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.zero,
                                    child: Icon(
                                      Icons.phone_android_rounded,
                                      size: MediaQuery.of(context).size.width /
                                          20.55,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  label: Text(
                                    AppTexts.phoneText,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: ColorConstants.purple,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                200,
                                      )),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppTexts.phoneEmpty;
                                  } else if (value.length < 11 ||
                                      value.length > 11) {
                                    return AppTexts.phoneDigit;
                                  } else if (value.startsWith("03") &&
                                      (value.length == 11)) {
                                    return null;
                                  } else {
                                    return AppTexts.phoneInvalid;
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 60),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 5,
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Card(
                                surfaceTintColor: Colors.white,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: ColorConstants.purple,
                                      width: 2.w
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: _imageFile == null
                                          ? Container(
                                              alignment: Alignment.topCenter,
                                              child: Center(
                                                child: Text("No Image Selected", style: TextStyle(fontSize: 12.sp),
                                                ),
                                              ))
                                          : Container(
                                              margin: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      18),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  8,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  7,
                                              child: Image.file(
                                                _imageFile!,
                                              ),
                                            ),
                                    ),
                                    Container(
                                        alignment: Alignment.bottomCenter,
                                        child: ElevatedButton.icon(

                                          onPressed: () {
                                            setState(() {
                                              _pickImage(ImageSource.gallery);
                                            });
                                          },
                                          icon: Icon(Icons.image,size: 22.sp,color: Colors.white,),
                                          label: Text("Select Image", style: TextStyle(fontSize: 10.sp,color: Colors.white),
                                          ),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      ColorConstants.purple)),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 60),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 20,
                                  right:
                                      MediaQuery.of(context).size.width / 20),
                              child: TextFormField(
                                style: TextStyle(fontSize: 13.sp),
                                autofocus: false,
                                controller: addressController,
                                keyboardType: TextInputType.streetAddress,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorConstants.purple,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                200,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorConstants.purple,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                200,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorConstants.purple,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                200,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.zero,
                                    child: Icon(
                                      Icons.location_pin,
                                      size: MediaQuery.of(context).size.width /
                                          20.55,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  label: Text(
                                    "Gallery Address",
                                    style: TextStyle(
                                      fontSize:
                                      13.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: ColorConstants.purple,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                200,
                                      )),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppTexts.addressEmpty;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 60),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 20,
                                  right:
                                      MediaQuery.of(context).size.width / 20),
                              child: TextFormField(
                                style: TextStyle(fontSize: 13.sp),
                                maxLines: 8,
                                maxLength: 50,
                                autofocus: false,
                                controller: sumaryController,
                                keyboardType: TextInputType.streetAddress,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorConstants.purple,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                200,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorConstants.purple,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                200,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorConstants.purple,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                200,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.zero,
                                    child: Icon(
                                      Icons.summarize,
                                      size: MediaQuery.of(context).size.width /
                                          20.55,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  label: Text(
                                    "Detail about what type of product you want to sell",
                                    style: TextStyle(
                                      fontSize:
                                      13.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: ColorConstants.purple,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                200,
                                      )),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Summary Field is Empty";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 60),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 20,
                                  right:
                                  MediaQuery.of(context).size.width / 20),
                              child: DropDownTextField.multiSelection(
                                submitButtonColor: ColorConstants.purple,
                                textStyle: TextStyle(fontSize: 13.sp),
                                listTextStyle: TextStyle(fontSize: 13.sp,),
                                submitButtonTextStyle: TextStyle(color: Colors.white,fontSize: 13.sp),
                                textFieldDecoration: InputDecoration(
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorConstants.purple,
                                        width:
                                        MediaQuery.of(context).size.width /
                                            200,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorConstants.purple,
                                        width:
                                        MediaQuery.of(context).size.width /
                                            200,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ColorConstants.purple,
                                        width:
                                        MediaQuery.of(context).size.width /
                                            200,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.zero,
                                    child: Icon(
                                      Icons.type_specimen,
                                      size: MediaQuery.of(context).size.width /
                                          20.55,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  label: Text(
                                    "Type",
                                    style: TextStyle(
                                      fontSize:
                                      10.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: ColorConstants.purple,
                                        width:
                                        MediaQuery.of(context).size.width /
                                            200,
                                      )),
                                ),
                                // controller: _cntMulti,
                                displayCompleteItem: true,
                                dropDownList: const [
                                  DropDownValueModel(name: 'Paint', value: "Paint"),
                                  DropDownValueModel(name: 'Painting', value: "Painting"),
                                  DropDownValueModel(
                                      name: 'Sketch',
                                      value: "Sketch",
                                      toolTipMsg:
                                      "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                                  DropDownValueModel(
                                      name: 'NFT',
                                      value: "NFT",
                                      toolTipMsg:
                                      "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                                ],
                                onChanged: (dynamic val) {
                                  setState(() {
                                    selectedValues = val as List<DropDownValueModel>;
                                  });
                                },


                              ),
                            ),
                            SizedBox(
                                height:
                                MediaQuery.of(context).size.height / 60),

                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.11,
                              height: MediaQuery.of(context).size.height / 18.23,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstants.purple,
                                  minimumSize: Size(260.w, 40.h),
                                  maximumSize: Size(260.w, 40.h),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10))),
                                  elevation: 30,
                                ),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    try {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            surfaceTintColor: Colors.white,
                                            backgroundColor: Colors.transparent,
                                            clipBehavior: Clip.none,
                                            title: Center(
                                              child: CircularProgressIndicator(
                                                color: ColorConstants.purple,
                                              ),
                                            ),
                                          );
                                        },
                                      );

                                      // String imageUrl = '';
                                      //
                                      // // Check if an image file is selected
                                      // if (_imageFile != null) {
                                      //   String imageName = DateTime.now().millisecondsSinceEpoch.toString();
                                      //   firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance
                                      //       .ref()
                                      //       .child('restaurant_images')
                                      //       .child('$imageName.jpg');
                                      //   // Upload image to Firebase Storage
                                      //   // Reference storageReference = FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}${PathExtension.extension(_imageFile!.path)}');
                                      //   UploadTask uploadTask = storageRef.putFile(_imageFile!);
                                      //
                                      //   // Listen to the upload progress
                                      //   uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
                                      //     double progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
                                      //     print('Upload progress: $progress%');
                                      //   }, onError: (error) {
                                      //     print('Upload error: $error');
                                      //   });
                                      //
                                      //   // Wait for the upload to complete
                                      //   await uploadTask.whenComplete(() {
                                      //     print('Upload complete');
                                      //   });
                                      //
                                      //   imageUrl = await storageRef.getDownloadURL();
                                      // }
                                      //
                                      // // Add data to Firestore collection
                                      // await FirebaseFirestore.instance.collection("Restaurants").doc().set({
                                      //   'restaurantName': restaurantNameController.text,
                                      //   'email': authService.currentUser!.email,
                                      //   'phoneNumber': phoneNumberController.text,
                                      //   'address': addressController.text,
                                      //   'summary': sumaryController.text,
                                      //   'status': 'Pending',
                                      //   'uid': authService.currentUser!.uid,
                                      //   'content': selectedValues.map((item) => item.value).toList(),
                                      //
                                      //   'image_url': imageUrl,
                                      // });

                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          title: Column(
                                            children: <Widget>[
                                              Text(
                                                "Congratulations",
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          content: Text(
                                            "Your Restaurant Is Created and Pending for Approval",
                                            style: TextStyle(fontSize: 10.sp, color: ColorConstants.purple),
                                          ),
                                          actions: <Widget>[
                                            Divider(color: Colors.black54),
                                            CupertinoDialogAction(
                                              child: Text(
                                                "Ok",
                                                style: TextStyle(color: Colors.black),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    } on FirebaseAuthException catch (error) {
                                      handleSignError(error);
                                    }
                                  }
                                },
                                child: Text(
                                  AppTexts.submit,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),


                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width / 1.11,
                            //   height:
                            //       MediaQuery.of(context).size.height / 18.23,
                            //   child: ElevatedButton(
                            //       //login button
                            //       onPressed: () async {
                            //         if (formKey.currentState!.validate()) {
                            //           try {
                            //             showDialog(
                            //                 context: context,
                            //                 builder: (context) {
                            //                   return AlertDialog(
                            //                     backgroundColor:
                            //                         Colors.transparent,
                            //                     clipBehavior: Clip.none,
                            //                     title: Center(
                            //                       child:
                            //                           CircularProgressIndicator(
                            //                         color: ColorConstants.purple,
                            //                       ),
                            //                     ),
                            //                   );
                            //                 });
                            //             await FirebaseFirestore.instance
                            //                 .collection("Restaurants")
                            //                 .doc()
                            //                 .set({
                            //               'restaurantName':
                            //                   restaurantNameController.text,
                            //               'email':
                            //                   authService.currentUser!.email,
                            //               'phoneNumber':
                            //                   phoneNumberController.text,
                            //               'address': addressController.text,
                            //               'summary': sumaryController.text,
                            //               'status': 'Pending',
                            //               'uid': authService.currentUser!.uid,
                            //               // 'image_url': url,
                            //             });
                            //             await showDialog(
                            //                 context: context,
                            //                 builder: (context) => AlertDialog(
                            //                       shape: RoundedRectangleBorder(
                            //                           borderRadius:
                            //                               BorderRadius.circular(
                            //                                   10)),
                            //                       title: Column(
                            //                         children: <Widget>[
                            //                           Divider(color: Colors.black54,),
                            //                           Text(
                            //                             "Congratulations",
                            //                             style: TextStyle(
                            //                                 color:
                            //                                     Colors.black),
                            //                           ),
                            //                         ],
                            //                       ),
                            //                       content: Text(
                            //                           "Your Restaurant Is Created, And Pending For Approval",
                            //                           style: TextStyle(
                            //                             fontSize: 12.sp,
                            //                               color: ColorConstants.purple)),
                            //                       actions: <Widget>[
                            //                         CupertinoDialogAction(
                            //                           child: Text(
                            //                             "Ok",
                            //                             style: TextStyle(
                            //                                 color:
                            //                                     Colors.black),
                            //                           ),
                            //                           onPressed: () {
                            //                             Navigator.pop(context);
                            //                             Navigator.pop(context);
                            //                             Navigator.pop(context);
                            //                            },
                            //                         ),
                            //                       ],
                            //                     ));
                            //           } on FirebaseAuthException catch (error) {
                            //             handleSignError(error);
                            //           }
                            //         }
                            //       },
                            //       style: ButtonStyle(
                            //         backgroundColor: MaterialStateProperty.all(
                            //             ColorConstants.purple),
                            //         shape: MaterialStateProperty.all<
                            //                 RoundedRectangleBorder>(
                            //             RoundedRectangleBorder(
                            //                 borderRadius: BorderRadius.all(Radius.circular(10),)
                            //         )),
                            //       ),
                            //       child: Text(
                            //         AppTexts.submit,
                            //         style: TextStyle(
                            //           fontWeight: FontWeight.w700,
                            //           color: Colors.white,
                            //         ),
                            //       )),
                            // ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
