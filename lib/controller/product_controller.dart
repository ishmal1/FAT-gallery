import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/color_constant.dart';

class ProductController extends GetxController {
  @override
  void onInit() {
    uploadImage();
    super.onInit();
  }

  var stream;
  File? image;
  final picker = ImagePicker();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future uploadImage() async {
    try {
      final pickerdImage = await picker.pickImage(
          source: ImageSource.gallery, imageQuality: 100);
      if (pickerdImage != null) {
        image = File(pickerdImage.path);
        // logs
        print("Image : $image");
      } else {
        Fluttertoast.showToast(
            msg: "No Image Selected", backgroundColor: ColorConstants.purple);
      }
    } catch (e) {
      print("Error is $e");
    }
  }

  // Stream to show Products
  // Stream should not be in Future
  Stream<QuerySnapshot<Map<String, dynamic>>> getStream() {
    return FirebaseFirestore.instance
        .collection('Products')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  // Delete Product

}
