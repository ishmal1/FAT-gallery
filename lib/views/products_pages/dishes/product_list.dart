import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_signup/firebase/auth_service/auth_service.dart';
import 'package:login_signup/utils/image_constant.dart';
import 'package:login_signup/views/products_pages/dishes/product_info.dart';
import '../../../constants/big_text.dart';
import '../../../constants/small_text.dart';
import '../../../firebase/firestore_fetch_data/fetch_user_data.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/images/images.dart';
import '../../../utils/strings/app_string.dart';
import '../../connectivity_wrapper.dart';
import 'add_dishes.dart';

class product_list extends StatefulWidget {
  final String restaurantId;

  const product_list({Key? key, required this.restaurantId}) : super(key: key);

  @override
  State<product_list> createState() => _product_listState();
}

class _product_listState extends State<product_list> {

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
    // print("$restaurantImageUrl");

    CollectionReference dishes = FirebaseFirestore.instance.collection("Dishes").doc(widget.restaurantId).collection("Rest_Dishes");

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
                      StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Restaurants').doc(widget.restaurantId).snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator(color: ColorConstants.purple);
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
                          final restaurantData = snapshot.data!.data() as Map<String, dynamic>;
                          restaurantImageUrl = restaurantData['image_url'];

                          return Container(
                            margin: EdgeInsets.only(
                              top: 25.h,
                            ),
                            clipBehavior: Clip.none,
                            child: restaurantImageUrl == null ?  CircleAvatar(
                              //food image
                              radius: MediaQuery.of(context).size.height / 10,
                              foregroundColor: Colors.transparent,
                              foregroundImage: AssetImage(ImageConstant.watch),
                              backgroundColor: Colors.transparent,
                            ) : FullScreenWidget(
                              disposeLevel: DisposeLevel.Low,
                              child: CircleAvatar(
                                //food image
                                radius: MediaQuery.of(context).size.height / 10,
                                foregroundColor: Colors.transparent,
                                foregroundImage: CachedNetworkImageProvider(restaurantImageUrl!),
                                backgroundColor: Colors.transparent,
                              ),
                            )
                          );

                          // Rest of your code...
                        },
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
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Dishes')
                    .doc(widget.restaurantId)
                    .collection('Rest_Dishes')
                    .snapshots(),
                builder: (context, dishSnapshot) {
                  if (dishSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(color: ColorConstants.purple,));
                  }
                  if (dishSnapshot.hasError) {
                    return const Center(
                      child: Text('Snapshot error'),
                    );
                  }
                  if (!dishSnapshot.hasData) {
                    return const Center(
                      child: Text('Snapshot data missing'),
                    );
                  }
                  final dishes = dishSnapshot.data!.docs;
                  return ListView.builder(
                    itemCount: dishes.length,
                    itemBuilder: (context, index) {
                      final dish = dishes[index].data() as Map<String, dynamic>;
                      List<dynamic> images = dish['images'] as List<dynamic>;
                      String firstImage = images.isNotEmpty ? images[0] as String : '';



                      return InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => product_info(
                                restaurantId: widget.restaurantId,
                                dishId: dishes[index].id,
                              ),
                            ),
                          );
                          final userId = FirebaseAuth.instance.currentUser?.uid;

                          // final userId = FirebaseAuth.instance.currentUser?.uid;
                          if (userId != null) {
                            final disheId = dishes[index].id;
                            final searchCollectionRef = FirebaseFirestore.instance.collection('SearchCollection').doc(userId).collection("Arts");

                            searchCollectionRef
                                .where('dishId',
                                isEqualTo:
                                disheId)
                                .get()
                                .then(
                                    (querySnapshot) {
                                  if (querySnapshot.size >
                                      0) {
                                    // Document already exists, update it
                                    final docId =
                                        querySnapshot
                                            .docs[0].id;
                                    searchCollectionRef
                                        .doc(docId)
                                        .update({
                                      'timestamp':
                                      DateTime.now(),
                                    }).then((_) {
                                      // Document updated successfully
                                      print(
                                          'Restaurant document updated in search collection');
                                    }).catchError(
                                            (error) {
                                          // Error occurred while updating document
                                          print(
                                              'Error updating restaurant document in search collection: $error');
                                        });
                                  } else {
                                    // Document doesn't exist, add it
                                    searchCollectionRef
                                        .add({
                                      'restaurantId': widget.restaurantId,
                                          "dishId": dishes[index].id,
                                          "userId" : userId,
                                          'viewed' : true,
                                          'timestamp': DateTime.now(),
                                    }).then((_) {
                                      // Restaurant added successfully
                                      print(
                                          'Restaurant added to search collection');
                                    }).catchError(
                                            (error) {
                                          // Error occurred while adding restaurant
                                          print(
                                              'Error adding restaurant to search collection: $error');
                                        });
                                  }
                                }).catchError((error) {
                              // Error occurred while querying the collection
                              print(
                                  'Error querying search collection: $error');
                            });
                          }
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
                                firstImage == null ? Container(
                                  width: 85.w,
                                  height: 85.h,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.only(bottomLeft: Radius.circular(5),topLeft: Radius.circular(5)),
                                      // color: Colors.white38,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(ImageConstant.watch))),
                                ) : FullScreenWidget(
                                  disposeLevel: DisposeLevel.Low,
                                  child: Container(
                                    width: 85.w,
                                    height: 85.h,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.only(bottomLeft: Radius.circular(5),topLeft: Radius.circular(5)),
                                        // color: Colors.white38,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: CachedNetworkImageProvider(firstImage))),
                                  ),
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
                                            text: dish['dishName'],
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
                                             dish['detail'],
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
                                        '\$ ${dish['price']}',
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
                  );
                },
              ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddDishes(documentId: widget.restaurantId)));
        },
        backgroundColor: ColorConstants.purple,
        label: Text(
          'Add Arts',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 8.sp,
          ),
        ),
      ));
  }
}
