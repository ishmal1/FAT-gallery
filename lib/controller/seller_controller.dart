import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:login_signup/controller/product_controller.dart';

import 'auth_controller.dart';

class SellerController extends GetxController {
  final AuthController authController = AuthController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final ProductController productController = ProductController();
  final collection = FirebaseFirestore.instance.collection('Products');
  RxInt totalProduct = 0.obs;

  @override
  void onInit() {
    totalProducts();
    super.onInit();
  }

// total numbers of products

  void totalProducts() async {
    await collection
        .where('uid', isEqualTo: firebaseAuth.currentUser!.uid)
        .get()
        .then((snapshot) {
      totalProduct = snapshot.size.obs;
    });
    print(totalProduct);
  }
}
