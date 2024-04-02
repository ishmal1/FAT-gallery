import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_signup/firebase/auth_service/auth_service.dart';
import 'package:login_signup/views/galleries_screens/components/getwaitinglist_screen.dart';

import '../../../utils/color_constant.dart';
import '../products_pages/restaurant_admin.dart';


class waiting_galleries extends StatefulWidget {
  const waiting_galleries({Key? key}) : super(key: key);

  @override
  State<waiting_galleries> createState() => _waiting_galleriesState();
}

class _waiting_galleriesState extends State<waiting_galleries> {


  @override
  Widget build(BuildContext context) {
    List<Album> albums = [
      Album(
        id: "1",
        title: 'Random Access Memories',
        artist: 'Daft Punk',
        status: "Waiting",
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/800px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg',
        phoneNumber: '+1234567890', // Example phone number
        email: 'daftpunk@example.com', // Example email
        address: '123 Music Street, City A', // Example address
      ),
      Album(
        id: "2",
        title: 'Abbey Road',
        artist: 'The Beatles',
        status: "Waiting",
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/800px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg',
        phoneNumber: '+1987654321', // Example phone number
        email: 'beatles@example.com', // Example email
        address: '456 Melody Avenue, City B', // Example address
      ),
      Album(
        id: "3",
        title: 'Dark Side of the Moon',
        artist: 'Pink Floyd',
        status: "Waiting",
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
        status: "Waiting",
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
          "Waiting Product",
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
              title: getWaiting_galleries(
                  album: album,
              ),
            );
          }),
    );
  }
}
