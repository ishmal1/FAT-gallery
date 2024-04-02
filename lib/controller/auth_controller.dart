import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../utils/color_constant.dart';

class AuthController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final name = "".obs;
  final email = "".obs;
  var currentUid;
  var collection;

  void registerUser(String email, password, name, roll) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        postdetails(name, email, password, roll.toString());
      });
    } on FirebaseException catch (e) {
      if (e.code == 'email-already-exist') {
        Fluttertoast.showToast(
          msg: 'Email Already Registered',
          backgroundColor: ColorConstants.purple,
        );
      } else if (e.code == 'weak-password') {
        Fluttertoast.showToast(
            msg: "Password is too Weak",
            backgroundColor: ColorConstants.purple);
      }
    }
  }

  postdetails(String name, email, password, roll) async {
    print(currentUid);
    CollectionReference ref = FirebaseFirestore.instance.collection('Users');
    ref.doc(currentUid.toString()).set({
      'name': name,
      'email': email,
      'password': password,
      'role': roll.toString(),
      'id': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  signInUser(String email, password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      currentUid = FirebaseAuth.instance.currentUser!.uid;
      // route();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: 'User Not Found',
          backgroundColor: ColorConstants.purple,
        );
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: 'Invalid Email or Password',
          backgroundColor: ColorConstants.purple,
        );
      } else if (e.code == 'waiting') {
        print("waiting");
        Visibility(
          visible: true,
          child: SpinKitCircle(
            color: Colors.blue,
            size: 50.0,
          ),
        );
      } else {
        print("No Internet Connection");
      }
    }
  }
  // Multi Users login with Single
  // void route() {
  //   FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(currentUid.toString())
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     print(documentSnapshot);
  //     if (documentSnapshot.exists) {
  //       if (documentSnapshot.get('role') == "Seller") {
  //         Get.off(() => Seller_dashbaord());
  //       } else {
  //         Get.off(() => const home_screen());
  //       }
  //     } else {
  //       print('Document does not exist on the database');
  //     }
  //   });
  // }

// loader dialog
  showLoaderDialog(BuildContext context, String text) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: <Widget>[
          const CircularProgressIndicator(),
          Container(margin: const EdgeInsets.only(left: 7), child: Text(text)),
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  Future getCurrentUserData() async {
    try {
      collection = FirebaseFirestore.instance
          .collection('Users')
          .where("id", isEqualTo: currentUid);

      collection.get().then((value) {
        email.value = value.docs[0].data()['email'];
        name.value = value.docs[0].data()['name'];
      });
      // update will work as notifier in MVC Getx
      update();
      print(email);
      print(name);
    } catch (e) {
      print("Error : $e");
    }
  }
}
