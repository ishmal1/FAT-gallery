// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../utils/auth_service/auth_service.dart';

// String email_firestoe = "";
// String phone_firestore = "";
// String name_firestore = "";
// String role_firestore = "";
// String status_firestore = "";
// bool restaurant_admin = false;
// bool rider = false;
// bool admin = false;

// Future fetchData() async{
//   // var doc_ref = await FirebaseFirestore.instance.collection("Users").get();
//   var collection = FirebaseFirestore.instance.collection('Users').where("uid", isEqualTo: AuthService().currentUser!.uid);

//   await collection.get().then((value) => {
//     email_firestoe = value.docs[0].data()["email"]
//   });

//   await collection.get().then((value) => {
//     name_firestore = value.docs[0].data()["displayName"]
//   });

//   await collection.get().then((value) => {
//     status_firestore = value.docs[0].data()["status"]
//   });

//   await collection.get().then((value) => {
//     phone_firestore = value.docs[0].data()["phoneNumber"],
//   });

//   await collection.get().then((value) => {
//     role_firestore = value.docs[0].data()["role"],
//   });

//  await collection.get().then((value) => {
//     restaurant_admin = value.docs[0].data()["seller"],
//   });

//   await collection.get().then((value) => {
//     rider = value.docs[0].data()["rider"],
//   });

//   await collection.get().then((value) => {
//     admin = value.docs[0].data()["admin"],
//   });
// }

