import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/firebase/auth_service/auth_service.dart';

class AddCart extends StatelessWidget {
  final QueryDocumentSnapshot dishId;
  final String restID;
  const AddCart({Key? key, required this.dishId, required this.restID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // FirebaseFirestore.instance
        //     .collection("Dishes")
        //     .doc(restID)
        //     .collection('Rest_Dishes')
        //     .doc(dishId.reference.id).delete();
        print(AuthService().currentUser!.uid);
      },
      icon: Icon(Icons.add_shopping_cart, color: Colors.red),
    );
  }
}
