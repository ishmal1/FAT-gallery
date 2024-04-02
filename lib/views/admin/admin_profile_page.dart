import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_signup/firebase/auth_service/auth_service.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:login_signup/views/admin/help&support_screen.dart';
import 'package:login_signup/views/admin/admin_home_screen/adminhome_screen.dart';
import 'package:login_signup/views/admin/notifications_screen.dart';
import '../../components/admin_textfield_screen.dart';
import '../../components/drawer_view.dart';
import '../../controller/auth_controller.dart';
import '../../utils/color_constant.dart';
import '../../utils/image_constant.dart';
import '../../widgets/custom_button.dart';
import 'login_page/admin_login.dart';

class admin_profile_page extends StatefulWidget {
  const admin_profile_page({Key? key}) : super(key: key);

  @override
  State<admin_profile_page> createState() => _admin_profile_pageState();
}

class _admin_profile_pageState extends State<admin_profile_page> {

  String image = "";


  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchUserDataFromFirestore();
  }

  void fetchUserDataFromFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where("uid", isEqualTo: user.uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
        Map<String, dynamic> userData = snapshot.docs[0].data() as Map<String, dynamic>;
        print('User Data: $userData');
        setState(() {
          nameController.text = userData['displayName'];
          phoneController.text = userData['phoneNumber'];
          emailController.text = userData['email'];
          addressController.text = userData['address'];
          image = userData['image'];
        });
      }
    }
  }

  void updateUserDataInFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('uid', isEqualTo: user.uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
        DocumentReference docRef = snapshot.docs[0].reference;

        await docRef.update({
          'displayName': nameController.text,
          'phoneNumber': phoneController.text,
          'email': emailController.text,
          'address': addressController.text,
        });

        print('User data updated successfully.');

        // Fetch the updated data from Firestore and print it
        DocumentSnapshot updatedSnapshot = await docRef.get();
        if (updatedSnapshot.exists) {
          Map<String, dynamic> updatedData =
          updatedSnapshot.data() as Map<String, dynamic>;
          print('Updated User Data: $updatedData');
          setState(() {
            nameController.text = updatedData['displayName'];
            phoneController.text = updatedData['phoneNumber'];
            emailController.text = updatedData['email'];
            addressController.text = updatedData['address'];
          });
        }
      }
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

  Future<void> _uploadImage() async {
    try {
      if (_imageFile == null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('No image selected.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        );
        return;
      }

      // Get the current user's ID
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Upload the image to Firebase Storage
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child(userId)
          .child('$imageName.jpg');
      firebase_storage.UploadTask uploadTask = storageRef.putFile(_imageFile!);

      // Monitor the upload task
      uploadTask.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
        print('Upload progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100}%');
      }, onError: (error) {
        print('Upload error: $error');
      });

      // Wait for the upload to complete
      await uploadTask.whenComplete(() {
        print('Upload complete');
      });

      // Get the image download URL
      String imageUrl = await storageRef.getDownloadURL();

      // Check if the document exists in Firestore
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('uid', isEqualTo: AuthService().currentUser?.uid)
          .limit(1)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        // Document exists, update the existing document
        String docId = userSnapshot.docs[0].id;

        await FirebaseFirestore.instance
            .collection('Users')
            .doc(docId)
            .update({'image': imageUrl});
      } else {
        // Document doesn't exist, create a new document
        await FirebaseFirestore.instance.collection('Users').add({
          'image': imageUrl,
        });
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Image uploaded successfully.'),
            actions: [
              TextButton(
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
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to upload image.'),
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
                itemBuilder: (context){
                  return [
                    PopupMenuItem<int>(
                        value: 0,
                        child: TextButton.icon(
                            onPressed: (){
                              Get.to(adminhome_screen());
                            }, icon: Icon(Icons.home), label: Text("Dashboard",style: TextStyle(color: Colors.black),))),

                    PopupMenuItem<int>(
                        value: 1,
                        child: TextButton.icon(
                            onPressed: (){
                              // Get.to(notifications_screen());
                            }, icon: Icon(Icons.notifications_active), label: Text("Notifications",style: TextStyle(color: Colors.black),))),

                    PopupMenuItem<int>(
                        value: 2,
                        child: TextButton.icon(
                            onPressed: (){
                              Get.to(helpsupport_screen());
                            }, icon: Icon(Icons.help), label: Text("Help & Support",style: TextStyle(color: Colors.black),))),

                    PopupMenuItem<int>(
                        value: 3,
                        child: TextButton.icon(
                            onPressed: (){
                              Timer(const Duration(seconds: 4), () {
                                AuthController().showLoaderDialog(context, "signing out");
                              });
                              FirebaseAuth auth = FirebaseAuth.instance;
                              auth.signOut();
                              Get.offAll(const adminlogin_screen());
                            }, icon: Icon(Icons.logout), label: Text("Logout",style: TextStyle(color: Colors.black),))),
                  ];
                },
                onSelected:(value){
                  if(value == 0){
                    print("My account menu is selected.");
                  }else if(value == 1){
                    print("Settings menu is selected.");
                  }else if(value == 2) {
                    print("Logout menu is selected.");
                  }else if(value == 3){
                    print("Logout menu is selected.");
                  }
                }
            ),
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
                  height: 570.h,
                  width: 300.w,
                  child: Card(
                    color: ColorConstants.grey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 130.w,
                          height: 500.h,
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            color: Colors.white,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 15.h,left: 5.w,right: 5.w),
                                  child: Image(
                                    width: 120.w,
                                    image: CachedNetworkImageProvider(image),),
                                  ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Icon(Icons.person,size: 8.sp,color: ColorConstants.purple,),
                                            SizedBox(width: 5.w,),
                                            Text("My Profile",style: TextStyle(
                                                fontSize: 5.sp,
                                                fontFamily: "Times New Roman",

                                                fontWeight: FontWeight.w700
                                            ),)
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10.h,),

                                      TextFormField(
                                        textInputAction: TextInputAction.next,
                                        keyboardType : TextInputType.text,
                                        controller: nameController,
                                      ),
                                      SizedBox(height: 10.h,),

                                      TextFormField(
                                        textInputAction: TextInputAction.next,
                                        keyboardType : TextInputType.text,
                                        controller: phoneController,
                                      ),
                                      SizedBox(height: 10.h,),

                                      TextFormField(
                                        textInputAction: TextInputAction.next,
                                        keyboardType : TextInputType.text,
                                        controller: emailController,
                                      ),
                                      SizedBox(height: 20.h,),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                    width: 40.w,
                                    child: custom_button(label: "Save", backgroundcolor: ColorConstants.purple, textcolor: ColorConstants.white, function: (){
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
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
                                                  fontWeight: FontWeight.bold, fontSize: 6.sp),
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
                                                        fontSize: 4.sp, fontWeight: FontWeight.w600),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }))


                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 5.w,),
                        Padding(
                          padding: EdgeInsets.only(top: 13.w),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 130.w,
                                height: 240.h,
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 15.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.w,right: 10.w,),

                                          child: Text("Other Information",style: TextStyle(
                                            fontFamily: "Times New Roman",
                                              fontSize: 5.sp,
                                              fontWeight: FontWeight.w700
                                          ),),
                                        ),
                                        Divider(
                                          color: Colors.black45,
                                        ),
                                         Padding(
                                           padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h),
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               Text("Account Status",style: TextStyle(fontWeight: FontWeight.bold),),
                                               Container(
                                                 height: 25.h,
                                                width: 25.w,
                                                decoration: BoxDecoration(
                                                    color: "approval" == true
                                                        ? Colors.red
                                                        : Colors.green,
                                                  borderRadius: BorderRadius.circular(20)
                                                ),
                                                child: Center(child: Text("Approved",style: TextStyle(color: Colors.white,fontSize: 3.sp,fontWeight: FontWeight.bold),)),
                                        ),
                                             ],
                                           ),
                                         ),

                                        Padding(
                                          padding: EdgeInsets.only(left: 10.w,right: 10.w,),
                                          child: TextFormField(
                                            textInputAction: TextInputAction.next,
                                            keyboardType : TextInputType.text,
                                            controller: addressController,
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.h,),
                              SizedBox(
                                width: 130.w,
                                height: 240.h,
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 15.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.w,right: 10.w,),

                                          child: Text("Languages",style: TextStyle(
                                              fontSize: 5.sp,
                                              fontFamily: "Times New Roman",

                                              fontWeight: FontWeight.w700
                                          ),),
                                        ),
                                        Divider(
                                          color: Colors.black45,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.w,right: 10.w,),
                                          child: TextFormField(
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              hintText: "English"
                                            ),
                                            textInputAction: TextInputAction.next,
                                            keyboardType : TextInputType.text,
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        )
    );
  }
}
