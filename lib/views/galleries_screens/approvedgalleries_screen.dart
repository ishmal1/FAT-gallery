import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_signup/firebase/auth_service/auth_service.dart';

import '../../../utils/color_constant.dart';
import '../products_pages/restaurant_admin.dart';
import 'components/getapprovedlist_screen.dart';


class approved_galleries extends StatefulWidget {
  const approved_galleries({Key? key}) : super(key: key);

  @override
  State<approved_galleries> createState() => _approved_galleriesState();
}

class _approved_galleriesState extends State<approved_galleries> {
  AuthService authService = AuthService();
  File? image;
  List<Object> approveList = [];
  List<Object> requestList = [];
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

  Future getApprovedList() async {
    approveList.clear();
    var collection = await FirebaseFirestore.instance
        .collection('Restaurants').where('uid', isEqualTo: AuthService().currentUser!.uid)
        .where('status', isEqualTo: "Approved");
    await collection.get().then((value) => value.docs.forEach((element) {
      print(element.reference);
      approveList.add(element.reference.id);
    }));
  }

  Stream<QuerySnapshot> getApprovedListStream() {
    return FirebaseFirestore.instance
        .collection('Restaurants')
        .where('uid', isEqualTo: AuthService().currentUser!.uid)
        .where('status', isEqualTo: "Approved")
        .snapshots();
  }


  @override
  Widget build(BuildContext context) {
    List<Album> albums = [
      Album(
        id: "1",
        title: 'Random Access Memories',
        artist: 'Daft Punk',
        status: "Approved",
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/800px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg',
        phoneNumber: '+1234567890', // Example phone number
        email: 'daftpunk@example.com', // Example email
        address: '123 Music Street, City A', // Example address
      ),
      Album(
        id: "2",
        title: 'Abbey Road',
        artist: 'The Beatles',
        status: "Approved",
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/800px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg',
        phoneNumber: '+1987654321', // Example phone number
        email: 'beatles@example.com', // Example email
        address: '456 Melody Avenue, City B', // Example address
      ),
      Album(
        id: "3",
        title: 'Dark Side of the Moon',
        artist: 'Pink Floyd',
        status: "Approved",
        imageUrl:
        'https://upload.wikimedia.org/wikipedia/en/3/3b/Dark_Side_of_the_Moon.png',
        phoneNumber: '+1122334455', // Example phone number
        email: 'pinkfloyd@example.com', // Example email
        address: '789 Harmony Road, City C', // Example address
      ),
      Album(
        id: "4",
        title: 'Thriller',
        artist: 'Michael Jackson',
        status: "Approved",
        imageUrl:
        'https://upload.wikimedia.org/wikipedia/en/5/55/Michael_Jackson_-_Thriller.png',
        phoneNumber: '+1555099876', // Example phone number
        email: 'michaeljackson@example.com', // Example email
        address: '321 Rhythm Lane, City D', // Example address
      ),
      // Add more albums here...
    ];

    return Scaffold(
      backgroundColor: ColorConstants.grey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorConstants.black),
        backgroundColor: ColorConstants.grey,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Approved Product",
          style: TextStyle(
            fontSize: 18.sp,
            color: ColorConstants.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: albums.length,
          itemBuilder: (context, index) {
            final album = albums[index];
            return ListTile(
              title: getApproved_galleries(
                album: album,
              ),
            );
          }),
    );
  }
}
