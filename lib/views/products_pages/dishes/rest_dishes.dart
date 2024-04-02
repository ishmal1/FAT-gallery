import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_signup/firebase/auth_service/auth_service.dart';

import '../../../firebase/firestore_fetch_data/fetch_user_data.dart';
import '../../../utils/images/images.dart';
import '../../../utils/strings/app_string.dart';
import 'add_dishes.dart';
import 'dishes_card.dart';
// import '../../firebase/firestore_fetch_data/fetch_user_data.dart';
// import '../../utils/images/images.dart';
// import '../../utils/strings/app_string.dart';
// import '../admin/nav_bar/admin_navbar.dart';

class Dishes extends StatefulWidget {
  final String documentID;
  const Dishes({Key? key, required this.documentID}) : super(key: key);

  @override
  State<Dishes> createState() => _DishesState();
}

class _DishesState extends State<Dishes> {


  final GlobalKey<ScaffoldState> _key = GlobalKey();
  AuthService authService = AuthService();
  final formKey = GlobalKey<FormState>();
  File? image;
  final picker = ImagePicker();

  Future imagePicker() async {
    try {
      final pick = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pick != null) {
          image = File(pick.path);
        } else {
          print('No Image Selected');
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  List<Object> restaurantsList = [];
  Future getRestaurantsList() async {
    restaurantsList.clear();
    var doc;

    var collection = await FirebaseFirestore.instance
        .collection('Restaurants')
        .where('uid', isEqualTo: AuthService().currentUser!.uid);
    var querySnapshots =
    await collection.get().then((value) => value.docs.forEach((element) {
      // print(element.reference);
      restaurantsList.add(element.reference.id);
    }));
  }

  // Future switcher() async {
  //   var collection = FirebaseFirestore.instance
  //       .collection('Users')
  //       .where("uid", isEqualTo: AuthService().currentUser!.uid);
  //
  //   await collection
  //       .get()
  //       .then((value) => {role_firestore = value.docs[0].data()["role"]});
  //   // print(role_firestore);
  //   if (role_firestore == 'Admin') {
  //     return Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => AdminHomePage()));
  //   }else{
  //     Navigator.pop(context);
  //   }
  // }

  @override
  void dispose() {
    restaurantNameController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  //Text Controllers
  final TextEditingController restaurantNameController =
  TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference dishes =
    FirebaseFirestore
        .instance
        .collection("Dishes")
        .doc(widget.documentID)
        .collection("Rest_Dishes");

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35))),
              elevation: 3,
              color: Colors.grey.shade300,
              child: SizedBox(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //app bar -> back arrow
                        SafeArea(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                margin: EdgeInsets.only(
                                  left:
                                  MediaQuery.of(context).size.width / 41.1,
                                ),
                                child: const Icon(Icons.arrow_back_ios)),
                          ),
                        ),
                        //app bar -> menu icon
                        SafeArea(
                          child: InkWell(
                            onTap: () {
                              _key.currentState!.openEndDrawer();
                            },
                            child: Container(
                                margin: EdgeInsets.only(
                                  right: MediaQuery.of(context).size.width / 35,
                                ),
                                child: const Icon(Icons.menu)),
                          ),
                        )
                      ],
                    ),
                    //search bar
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Card(
                        elevation: 3,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        //search bar text field
                        child: TextField(
                          decoration: InputDecoration(
                            //search bar leading icon
                            prefixIcon: Icon(
                              Icons.search,
                              size: MediaQuery.of(context).size.width / 13.7,
                              color: Colors.black54,
                            ),
                            hintText: AppTexts.searchBar,
                            hintStyle: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.width / 22.8,
                              color: Colors.black54,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 34.2,
                              right: MediaQuery.of(context).size.width / 34.2,
                              top: MediaQuery.of(context).size.height / 60,
                              bottom: MediaQuery.of(context).size.height / 60,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //main image
                    Container(
                      margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 51.4,
                        top: MediaQuery.of(context).size.height / 82,
                      ),
                      clipBehavior: Clip.none,
                      child: CircleAvatar(
                        //food image
                        radius: MediaQuery.of(context).size.height / 8.5,
                        foregroundColor: Colors.transparent,
                        foregroundImage: AssetImage(AppImages.plateImg),
                        backgroundColor: Colors.transparent,
                      ),
                    ), //Text//SizedBox
                  ],
                ),
              ),
            ),
            //orange line before menu items
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 164.1,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width / 4.3,
                height: MediaQuery.of(context).size.height / 102.5,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.deepOrange,
                        Colors.orange,
                      ]),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            //space before 1st item menu
            SizedBox(
              height: MediaQuery.of(context).size.height / 80,
            ),
            Expanded(
              child: StreamBuilder(
                stream: dishes.snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Colors.deepOrange,));
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Snapshot error'),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('Snapshot data missing'),
                    );
                  }
                  return ListView(
                    children: snapshot.data!.docs.map<Widget>((restaurants) {
                      return DishesCard(dishes: restaurants,restID: widget.documentID,);
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddDishes(documentId: widget.documentID)));
        },
        backgroundColor: Colors.deepOrange,
        label: Text(
          'Add Dish',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width / 25,
          ),
        ),
      ),
    );
  }
}