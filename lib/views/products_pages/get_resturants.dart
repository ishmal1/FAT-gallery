import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_signup/utils/color_constant.dart';
import 'package:login_signup/utils/image_constant.dart';
import 'package:login_signup/views/products_pages/restaurant_admin.dart';

import '../../constants/big_text.dart';
import '../../firebase/auth_service/auth_service.dart';
import '../../utils/images/images.dart';
import 'dishes/add_dishes.dart';
import 'dishes/product_list.dart';

class GetRestaurants extends StatelessWidget {
  final Album album;

  late bool approval;

  GetRestaurants({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>dummy_product_list(album: this.album,)));
        // print(documentId);
      },
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        child: Container(
            padding:
            EdgeInsets.all(MediaQuery.of(context).size.height / 90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 4.2,
                  height: MediaQuery.of(context).size.height / 8.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white38,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(album.imageUrl))
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              ("Status : "),
                              style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w600),
                            ),
                            Text(
                              album.status,
                              style: TextStyle(
                                  color: album.status == "Approved"
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 10.sp,fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 250,
                        ),
                        Text(
                          album.title,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 12.sp,),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 160,
                        ),
                        Text(
                        album.phoneNumber,
                          style: TextStyle(fontSize: 9.sp,fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 250,
                        ),
                        Text(
                          album.email,
                          style: TextStyle(fontSize: 9.sp,fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 250,
                        ),
                        Text(
                          album.address,
                          style: TextStyle(fontSize: 9.sp,fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 9,
                  child: IconButton(
                      onPressed: () {

                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: MediaQuery.of(context).size.width / 19,
                      )),
                ),
              ],
            )),
      ),
    );
  }
}


class FineArt {
  final String name;
  final String artist;
  final double price;
  final String imageUrl;

  FineArt({
    required this.name,
    required this.artist,
    required this.price,
    required this.imageUrl,
  });
}


class dummy_product_list extends StatefulWidget {
  final Album album;

  const dummy_product_list({Key? key, required this.album}) : super(key: key);

  @override
  State<dummy_product_list> createState() => _dummy_product_listState();
}

class _dummy_product_listState extends State<dummy_product_list> {

  AuthService authService = AuthService();
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

  String? restaurantImageUrl;

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
    List<FineArt> fineArts = [
      FineArt(
        name: 'Mona Lisa',
        artist: 'Leonardo da Vinci',
        price: 1000000.00,
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/800px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg',
      ),
      FineArt(
        name: 'Starry Night',
        artist: 'Vincent van Gogh',
        price: 1500000.00,
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/800px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg',
      ),
      // Add more fine arts here...
    ];

    return Scaffold(
      backgroundColor: ColorConstants.grey,

      body: Column(
        children: [
          SizedBox(
            height: 250.h,
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35))),
              elevation: 3,
              color: Colors.white,
              child: SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(top: 45.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //app bar -> back arrow
                          InkWell(
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
                          Padding(
                            padding: EdgeInsets.only(right: 120.w),
                            child: Text("Product List",style: TextStyle(fontSize: 12.sp,color: Colors.black,fontWeight: FontWeight.bold),),
                          )
                          //app bar -> menu icon
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(
                            top: 25.h,
                          ),
                          clipBehavior: Clip.none,
                          child: CircleAvatar(
                            //food image
                            radius: MediaQuery.of(context).size.height / 10,
                            foregroundColor: Colors.transparent,
                            foregroundImage: NetworkImage(widget.album.imageUrl),
                            backgroundColor: Colors.transparent,
                          )
                      )

                      //main image
                      //Text//SizedBox
                    ],
                  ),
                ),
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
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      ColorConstants.purple,
                      ColorConstants.lightBlue,
                    ]),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          //space before 1st item menu

          // Expanded(
          //     child: FutureBuilder(
          //         future: getAllRestaurantsList(),
          //         builder: (context, snapshot) {
          //           return GridView.builder(
          //               scrollDirection:Axis. horizontal,
          //               gridDelegate:
          //               SliverGridDelegateWithFixedCrossAxisCount(
          //                   mainAxisExtent: 250, crossAxisCount:  1 ,),
          //               itemCount: List1.length,
          //               itemBuilder: (BuildContext ctx, index) {
          //                 return GestureDetector(
          //                   onTap: () {
          //                     var listindex = List1[index] as String;
          //                     print(List1[index] as String);
          //                     print(listindex);
          //                     Navigator.push(
          //                         context,
          //                         MaterialPageRoute(
          //                             builder: (context) =>
          //                                 product_info(documentID: List1[index] as String)));
          //                   },
          //                   child: Container(
          //                     alignment: Alignment.center,
          //                     child: ListTile(
          //                       contentPadding: EdgeInsets.zero,
          //                       title: Text("hi")
          //                     ),
          //                   ),
          //                 );
          //               });
          //         })),

          Expanded(
            child: ListView.builder(
              itemCount: fineArts.length,
              itemBuilder: (context, index) {
                final fineArt = fineArts[index];

                return InkWell(
                  onTap: (){

                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.w,right: 10.w),
                    child: Card(
                      surfaceTintColor: Colors.white,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          //food image of item 1
                        Container(
                            width: 85.w,
                            height: 85.h,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.only(bottomLeft: Radius.circular(5),topLeft: Radius.circular(5)),
                                // color: Colors.white38,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(fineArt.imageUrl))),
                          ),

                          //details of item  1
                          Container(
                            width: 130.w,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 41.1,
                                right: MediaQuery.of(context).size.width / 41.1,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  SizedBox(
                                    width: 100.w,
                                    child: BigText(
                                      text: fineArt.name,
                                      color: Colors.black,
                                      size: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  SizedBox(
                                    width: 100.w,
                                    child: Text(
                                      fineArt.artist,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(fontSize: 10.sp,
                                        color: Colors.black54,
                                        fontFamily: "Roboto",),

                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(
                                    // \$${totalPrice.toStringAsFixed(2)}
                                    // '(\$ ${dish['price']})',
                                    '\$ ${fineArt.price}',
                                    style: TextStyle(
                                      color: ColorConstants.purple,
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.w600,),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                          Icons.star,
                                          color: Colors.amberAccent,
                                          size: 14.sp
                                      ),
                                      SizedBox(
                                          width: 1.w
                                      ),
                                      Text("4.1",style: TextStyle(
                                        overflow: TextOverflow
                                            .ellipsis,
                                        fontSize: 10.sp,
                                        fontWeight:
                                        FontWeight.w500,
                                        color: Color.fromRGBO(
                                            10, 205, 70, 100),
                                      ),

                                      ),
                                      SizedBox(
                                          width: 10.w
                                      ),
                                      Text(
                                        "(4378, reviews)",style: TextStyle(
                                          overflow: TextOverflow
                                              .ellipsis,
                                          fontWeight:
                                          FontWeight.normal,
                                          color: Colors.black54,
                                          fontSize: 8.sp
                                      ),
                                      ),

                                    ],
                                  ),

                                  // restaurant_admin == true
                                  //     ? DeleteDish(
                                  //   dishId: dishes,
                                  //   restID: this.restID,
                                  // )
                                  //     : AddCart(dishId: dishes, restID: this.restID),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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
              MaterialPageRoute(builder: (context) => AddDishes(documentId: "widget.restaurantId")));
        },
        backgroundColor: ColorConstants.purple,
        label: Text(
          'Add Arts',
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
