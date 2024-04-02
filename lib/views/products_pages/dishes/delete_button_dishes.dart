import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteDish extends StatelessWidget {
  final QueryDocumentSnapshot dishId;
  final String restID;
  const DeleteDish({Key? key, required this.dishId, required this.restID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        FirebaseFirestore.instance
            .collection("Dishes")
            .doc(restID)
            .collection('Rest_Dishes')
            .doc(dishId.reference.id).delete();
        // print(restID);
      },
      icon: Icon(Icons.delete, color: Colors.red),
    );
  }
}
