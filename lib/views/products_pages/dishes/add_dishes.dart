import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../firebase/auth_service/auth_service.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/strings/app_string.dart';
import '../../notifications/notifications_page.dart';

class AddDishes extends StatefulWidget {


  final String documentId;
  AddDishes({Key? key, required this.documentId}) : super(key: key);

  @override
  State<AddDishes> createState() => _AddDishesState();
}

class _AddDishesState extends State<AddDishes> {






  final formKey = GlobalKey<FormState>();
  File? imageFile;
  final picker = ImagePicker();
  List<File> imageListFiles = [];


  List<DropDownValueModel> selectedValues = [];




  // final formkey = GlobalKey<FormState>();
  String? dropdownvalue ;




  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await picker.getImage(source: source);
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
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
  Future<void> _pickMultipleImages() async {
    try {
      final pickedFiles = await picker.getMultiImage(
        imageQuality: 100,
      ); // Use `getMultiImage` instead of `getImage`
      if (pickedFiles!.isNotEmpty) {
        setState(() {
          imageListFiles = pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
        });
      }
    } catch (error) {
      print('Failed to pick images: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to pick images.'),
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
    dishNameController.dispose();
    priceController.dispose();
    dishDetailController.dispose();
    descriptionController.dispose();
    yearController.dispose();
    discountController.dispose();
    super.dispose();
  }

  //Text Controllers
  final TextEditingController dishNameController =
      TextEditingController();
  final TextEditingController dishDetailController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

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
                    Container(
                      margin: EdgeInsets.only(
                          top: 1.h,bottom: 10.h),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Add Arts",
                              style: TextStyle(
                                  color: ColorConstants.purple,
                                  fontSize:
                                      18.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 200),
                            Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 160),
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
                                controller: dishNameController,
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
                                      Icons.art_track_sharp,
                                      size: MediaQuery.of(context).size.width /
                                          20.55,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  label: Text(
                                    "Art Name",
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
                                    return AppTexts.restaurantNameEmpty;
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

                                autofocus: false,
                                controller: yearController,
                                keyboardType: TextInputType.number,
                                maxLength: 4,
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
                                      Icons.date_range,
                                      size: MediaQuery.of(context).size.width /
                                          20.55,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  label: Text(
                                    "Year",
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
                                    return AppTexts.restaurantNameEmpty;
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

                                autofocus: false,
                                controller: discountController,
                                maxLength: 2,
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
                                      Icons.discount,
                                      size: MediaQuery.of(context).size.width /
                                          20.55,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  label: Text(
                                    "Discount",
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
                                    return "Empty";
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
                                controller: dishDetailController,
                                keyboardType: TextInputType.text,
                                maxLines: 4,
                                maxLength: 50,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Empty";
                                  } else {
                                    return null;
                                  }
                                },
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
                                      Icons.restaurant_menu,
                                      size: MediaQuery.of(context).size.width /
                                          20.55,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  label: Text(
                                    "Short Detail",
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
                                    imageListFiles.isNotEmpty
                                        ? GridView.builder(
                                          padding: EdgeInsets.only(left: 5.w,right: 5.w,top: 5.h),
                                          scrollDirection: Axis.vertical,
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 5,
                                            mainAxisSpacing: 10.h,
                                            crossAxisSpacing: 10.w,
                                          ),
                                          itemCount: imageListFiles.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return Image.file(
                                              imageListFiles[index],
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        )
                                        : Center(child: Text('No images selected',style: TextStyle(fontSize: 10.sp,color: Colors.black),)),
                                    Container(
                                        alignment: Alignment.bottomCenter,
                                        child: ElevatedButton.icon(

                                          onPressed: () {
                                            setState(() {
                                              _pickMultipleImages();
                                            });
                                          },
                                          icon: Icon(Icons.image,color: Colors.white,size: 22.sp,),
                                          label: Text("Select Image",style: TextStyle(fontSize: 10.sp,color: Colors.white),),
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
                                controller: priceController,
                                keyboardType: TextInputType.number,
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
                                      Icons.currency_exchange,
                                      size: MediaQuery.of(context).size.width /
                                          20.55,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  label: Text(
                                    "Price",
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
                                    return AppTexts.priceEmpty;
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
                                listTextStyle: TextStyle(fontSize: 13.sp),
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
                                // controller: _cntMulti,
                                displayCompleteItem: true,
                                dropDownList: const [
                                  DropDownValueModel(name: 'Oil Paint', value: "Oil Paint"),
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
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 20,
                                  right:
                                  MediaQuery.of(context).size.width / 20),
                              child: TextFormField(
                                style: TextStyle(fontSize: 13.sp),

                                maxLines: 5,
                                maxLength: 50,
                                autofocus: false,
                                controller: descriptionController,
                                keyboardType: TextInputType.multiline,
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
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.11,
                              height:
                                  MediaQuery.of(context).size.height / 18.23,

                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstants.purple,
                                  minimumSize: Size(260.w, 40.h),
                                  maximumSize: Size(260.w, 40.h),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10))),
                                  elevation: 30,
                                ),
                                // login button
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



                                      Navigator.pop(context); // Close the progress dialog

                                      await showDialog(
                                        context: context,
                                        builder: (context) => CupertinoAlertDialog(
                                          title: Column(
                                            children: <Widget>[
                                              Text(
                                                "Congratulations",
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          content: Text(
                                            "Your Art is Added",
                                            style: TextStyle(color: ColorConstants.purple,fontSize: 10.sp),
                                          ),
                                          actions: <Widget>[
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
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
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
