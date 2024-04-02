import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_signup/firebase/firestore_fetch_data/fetch_user_data.dart';
import '../components/text_fields.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../firebase/auth_service/auth_service.dart';
import '../utils/color_constant.dart';
import '../utils/image_constant.dart';
import '../widgets/custom_button.dart';


class editprofile_screen extends StatefulWidget {
  const editprofile_screen({Key? key}) : super(key: key);

  @override
  State<editprofile_screen> createState() => _editprofile_screenState();
}

class _editprofile_screenState extends State<editprofile_screen> {
  final formKey = GlobalKey<FormState>();


  String imageUrl = '';
  bool _uploadingImage = false;
  // late FileImage bytes;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();


  void updateUserDataInFirestore() async {
    if (formKey.currentState!.validate()) {


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
          return CupertinoAlertDialog(
            title: Text('Error'),
            content: Text('Failed to pick image.'),
            actions: [
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _uploadImage() async {
    try {
      if (_imageFile == null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text('Error'),
              content: Text('No image selected.'),
              actions: [
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        );
        return;
      }


      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Success'),
            content: Text('Image uploaded successfully.'),
            actions: [
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    } catch (error) {
      print('Error uploading image: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Error'),
            content: Text('Failed to upload image.'),
            actions: [
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }
  }

  // Validate Pakistani phone number
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter phone number';
    }

    // Remove any non-digit characters from the phone number
    String formattedPhoneNumber = value.replaceAll(RegExp(r'[^0-9]'), '');

    // Check if the formatted phone number is valid
    if (!RegExp(r'^(\+92|0)?3\d{9}$').hasMatch(formattedPhoneNumber)) {
      return 'Please enter a valid Pakistani phone number';
    }

    return null; // Return null for no validation errors
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _showConfirmationDialog() async {
    bool? shouldUpdate = await showDialog<bool>(
      context: scaffoldKey.currentContext!,
      builder: (BuildContext? dialogContext) {
        return CupertinoAlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to update your profile picture?'),
          actions: [
            CupertinoDialogAction(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(dialogContext!, false),
            ),
            CupertinoDialogAction(
              child: Text('Update'),
              onPressed: () => Navigator.pop(dialogContext!, true),
            ),
          ],
        );
      },
    );

    if (shouldUpdate == true) {
      setState(() {
        _uploadingImage = true; // Set the flag to indicate image uploading
      });

      await _pickImage(ImageSource.gallery);
      if (_imageFile != null) {
        await _uploadImage();

        setState(() {
          _uploadingImage = false; // Reset the flag after image uploading
        });

        showDialog(
          context: scaffoldKey.currentContext!,
          builder: (BuildContext successDialogContext) {
            return CupertinoAlertDialog(
              title: Text('Success'),
              content: Text('Image uploaded successfully.'),
              actions: [
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () => Navigator.pop(successDialogContext),
                ),
              ],
            );
          },
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: ColorConstants.grey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ColorConstants.black,
        ),
        elevation: 0.0,
        backgroundColor: ColorConstants.grey,

      ),

      body: Padding(
        padding: EdgeInsets.only(top: 15.h),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Personal info",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.h,),
                 FullScreenWidget(
                   disposeLevel: DisposeLevel.Low,
                   child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: MediaQuery.of(context).size.height / 14.1,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : AssetImage(ImageConstant.placeholder) as ImageProvider<Object>?,
                      // backgroundImage: imageUrl != null ? NetworkImage(imageUrl as String) : AssetImage(ImageConstant.placeholder),
                      child: Stack(children: [
                        Align(
                            heightFactor: 3.1.h,
                            alignment: Alignment.bottomRight,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: ColorConstants.purple,
                                  borderRadius: BorderRadius.circular(8)),
                              child: CircleAvatar(
                                  radius: MediaQuery.of(context).size.height / 70,
                                  backgroundColor: ColorConstants.purple,
                                  child: InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  ListTile(
                                                    leading:
                                                    const Icon(Icons.delete),
                                                    title:  Text("Delete Photo",style: TextStyle(fontSize: 8.sp),),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  ListTile(
                                                    leading: Icon(Icons.photo),
                                                    title: Text("Choose from Gallery",style: TextStyle(fontSize: 8.sp)),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      _showConfirmationDialog();
                                                    },
                                                  ),


                                                  ListTile(
                                                    leading:
                                                    const Icon(Icons.camera_alt),
                                                    title:
                                                    Text("Choose from Camera",style: TextStyle(fontSize: 8.sp)),
                                                    onTap: () {
                                                      _pickImage(ImageSource.camera);

                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size:
                                        MediaQuery.of(context).size.width / 20,
                                      )) // change this children
                              ),
                            ))
                      ])),
                 ),
                SizedBox(height: 10.h,),
                Text(
                  "Buyer",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h,),
                Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/20.5, right: MediaQuery.of(context).size.width/20.5,),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/80,),
                            child: Text(
                              "Name",style: TextStyle(fontSize: 13.sp,color: Colors.black,fontWeight: FontWeight.w600,),

                            ),
                          ),
                          SizedBox(height: 5.h,),
                          TextFormFieldWidget(
                            fillColor: Colors.white,
                            textInputType: TextInputType.text,
                            actionKeyboard: TextInputAction.next,
                            hintText: "Faizan Ahmed",
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter name';
                              }
                              // Additional validation logic can be added here
                              return null;
                            },
                            // hintText: name_firestore,
                          ),

                          SizedBox(height: 5.h,),

                          Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/80,top: 6.h),
                            child: Text(
                              "Email",style: TextStyle(fontSize: 13.sp,color: Colors.black,fontWeight: FontWeight.w600,),

                            ),
                          ),
                          SizedBox(height: 5.h,),
                          TextFormFieldWidget(
                              fillColor: Colors.white,
                              textInputType: TextInputType.text,
                              actionKeyboard: TextInputAction.next,
                            hintText: "faizanjutt480@gmail.co ",

                              controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email';
                              }
                              // Additional validation logic can be added here
                              return null;
                            },
                              // hintText: email_firestoe
                          ),

                          SizedBox(height: 5.h,),

                          Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/80,top: 6.h),
                            child: Text(
                              "Phone Number",style: TextStyle(fontSize: 13.sp,color: Colors.black,fontWeight: FontWeight.w600,),
                            ),
                          ),
                          SizedBox(height: 5.h,),
                          TextFormFieldWidget(
                            fillColor: Colors.white,
                            textInputType: TextInputType.number,
                            actionKeyboard: TextInputAction.next,
                            hintText: "03034992416",

                            controller: phoneController,
                            validator: (value) {
                              String? validationResult = validatePhoneNumber(value);
                              if (validationResult != null) {
                                return validationResult;
                              }
                              return null; // Return null for no validation errors
                            },
                            // hintText: phone_firestore,
                          ),

                          SizedBox(height: 5.h,),

                          Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/80,top: 6.h),
                            child: Text(
                              "Address",style: TextStyle(fontSize: 13.sp,color: Colors.black,fontWeight: FontWeight.w600,),

                            ),
                          ),
                          SizedBox(height: 5.h,),
                          TextFormFieldWidget(
                            fillColor: Colors.white,
                            textInputType: TextInputType.text,
                            actionKeyboard: TextInputAction.done,
                            controller: addressController,
                            hintText: "Mohala Abid Town Narowal",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              // Additional validation logic can be added here
                              return null;
                            },
                            // hintText: email_firestoe,
                          ),

                          SizedBox(height: 20.h,),
                          SizedBox(
                              width: 330.w,
                              child: custom_button(label: "Save", backgroundcolor: ColorConstants.purple, textcolor: ColorConstants.white, function: (){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      surfaceTintColor: Colors.white,
                                      backgroundColor: Colors.white,
                                      contentPadding: EdgeInsets.only(left: 18.w, right: 18.w),
                                      actions: [
                                        TextButton(
                                            style: TextButton.styleFrom(
                                              foregroundColor: ColorConstants.purple,
                                            ),
                                            onPressed: () {
                                              // updateUserDataInFirestore;
                                              updateUserDataInFirestore();

                                              Get.back();

                                            },
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                color: Colors.green,
                                              ),
                                            )),
                                        TextButton(
                                            style: TextButton.styleFrom(
                                              foregroundColor: ColorConstants.purple,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "No",
                                              style: TextStyle(color: Colors.red),
                                            )),
                                      ],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                      ),
                                      title: Text(
                                        'Updating User Profile',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 14.sp),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Image(
                                              height: 120.h,
                                              fit: BoxFit.cover,
                                              image: const AssetImage(
                                                'assets/images/listening.gif',
                                              )),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Are you sure you want to continue?',
                                              style: TextStyle(
                                                  fontSize: 12.sp, fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              })),

                          // SizedBox(
                          //     width: 330.w,
                          //     child: custom_button(label: "Edit", backgroundcolor: ColorConstants.purple, textcolor: ColorConstants.white, function: (){
                          //
                          //     }))

                        ])
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


