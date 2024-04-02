import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_signup/firebase/auth_service/auth_service.dart';
import 'package:login_signup/views/login/login_page.dart';
import '../../firebase/firestore_fetch_data/fetch_user_data.dart';
import '../../utils/color_constant.dart';
import '../../utils/images/images.dart';
import '../../utils/strings/app_string.dart';
import 'add_restaurants.dart';
import 'get_resturants.dart';
class Album {
  final String id;
  final String title;
  final String artist;
  final String status;
  final String imageUrl;
  final String phoneNumber;
  final String email;
  final String address;

  Album({
    required this.id,
    required this.title,
    required this.artist,
    required this.status,
    required this.imageUrl,
    required this.phoneNumber,
    required this.email,
    required this.address,
  });
}




class RestaurantAdmin extends StatefulWidget {
  const RestaurantAdmin({Key? key}) : super(key: key);

  @override
  State<RestaurantAdmin> createState() => _RestaurantAdminState();
}

class _RestaurantAdminState extends State<RestaurantAdmin> {



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
        status: "Pending",
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
          "Listed Product",
          style: TextStyle(
            fontSize: 18.sp,
            color: ColorConstants.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];

                return ListTile(
                  title: GetRestaurants(
                    album: album,
                  ),
                );
              },
            ),
        ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddRestaurants()));
        },
        backgroundColor: ColorConstants.purple,
        label: Text(
          'Add Gallery',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
