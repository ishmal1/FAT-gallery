import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../../../../utils/color_constant.dart';
import '../../../../utils/image_constant.dart';
import '../providers/fav_provider.dart';
import '../widgets/custom_button.dart';
import 'home_screen/buyer_home_screen.dart';

class favourite_item_screen extends StatelessWidget {
  const favourite_item_screen({key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> dummyFavoriteDishes = [
      {
        'artName': 'Mona Lisa',
        'artist': 'Leonardo da Vinci',
        'year': 1503,
        'price': 15.99,
        "quantity": "1"
      },
      {
        'artName': 'The Starry Night',
        'artist': 'Vincent van Gogh',
        'year': 1889,
        'price': 12.49,
        "quantity": "1"
      },
      // Add more dummy data items as needed
    ];




    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    return Scaffold(
      backgroundColor: ColorConstants.grey,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Favourites",
          style: TextStyle(
            color: ColorConstants.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorConstants.grey,
        iconTheme: IconThemeData(
          color: ColorConstants.black,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(left: 25.w,right: 25.w,),
              itemCount: dummyFavoriteDishes.length,
              itemBuilder: (context, index) {
                final dishData = dummyFavoriteDishes[index];


                return Container(
                  margin: EdgeInsets.only(top: 10.h),
                  child: Slidable(
                    closeOnScroll: true,
                    endActionPane: ActionPane(
                      extentRatio: 0.3,
                      motion: const DrawerMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  surfaceTintColor: Colors.white,
                                  backgroundColor: Colors.white,
                                  contentPadding: EdgeInsets.only(left: 18.w, right: 18.w),
                                  actions: [
                                    TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: ColorConstants.purple,
                                        ),
                                        onPressed: () {
                                          // FirebaseFirestore.instance.collection('Favorites').doc(userId).collection("Dishes").doc(favoriteDishes[index].id).delete();
                                          Get.back();
                                        },
                                        child: Text(
                                          "Yes",
                                          style: TextStyle(
                                            color: Colors.green,
                                          ),
                                        )),
                                    TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: ColorConstants.purple,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "No",
                                          style: TextStyle(color: Colors.red),
                                        )),
                                  ],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  title: Text(
                                    'Clearing Favourite',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 16.sp),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Image(
                                          height: 120.h,
                                          fit: BoxFit.cover,
                                          image: const AssetImage(
                                            'assets/images/listening.gif',
                                          )),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Are you sure you want to continue?',
                                          style: TextStyle(
                                              fontSize: 13.sp, fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                          label: "Delete",
                          borderRadius: BorderRadius.circular(5),
                          autoClose: true,
                        ),
                      ],
                    ),
                    child: Container(
                      width: 314.w,
                      height: 105.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 15.w, right: 15.w),
                        child: Row(
                          children: [Image(
                                width: 80.w,
                                height: 80.h,
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    ImageConstant.watch)),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10.w,
                                  top: 18.h,
                                  bottom: 18.h),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    dishData['artName'],
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight:
                                        FontWeight.w600),
                                  ),
                                  Text(
                                    dishData['artist'],
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight:
                                        FontWeight.w600),
                                  ),
                                  Text(
                                    "\$${dishData['price']}"
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight:
                                        FontWeight.w500,
                                        color: ColorConstants
                                            .purple),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Quantity",
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight:
                                            FontWeight
                                                .w400),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        dishData['quantity'].toString(),
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight:
                                            FontWeight
                                                .w600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ),
        ],
      ),
    );
  }
}

// Column(
// children: [
// const SizedBox(
// height: 40,
// ),
//
// Image(
// image: AssetImage(ImageConstant.favourite),
// ),
// Text(
// "No Favourites Yet",
// style: TextStyle(
// fontSize: 20,
// fontWeight: FontWeight.bold,
// color: ColorConstants.black,
// ),
// ),
// const SizedBox(
// height: 10,
// ),
// const Text(
// "Hit the Orange Button down\n       Below to create Order."),
// const SizedBox(
// height: 20,
// ),
// custom_button(
// label: "Start Adding",
// backgroundcolor: ColorConstants.lightBlue,
// textcolor: ColorConstants.white,
// function: () {
// Get.off(home_screen());
// })
// ],
// ),



// return ListTile(
// title: Text(dishData['dishName']),
// subtitle: Text('Price: \$${dishData['price']}'),
// trailing: IconButton(
// icon: Icon(Icons.delete),
// onPressed: () {
// // Delete the favorite dish from Firestore
// FirebaseFirestore.instance
//     .collection('Favorites')
//     .doc(favoriteDishes[index].id)
//     .delete();
// },
// ),
// );

class favourite_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final favoriteDishes = favoriteProvider.favoriteDishes;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Dishes'),
      ),
      body: ListView.builder(
        itemCount: favoriteDishes.length,
        itemBuilder: (context, index) {
          final dishId = favoriteDishes[index];

          // Replace this with your desired widget to display each favorite dish
          return ListTile(
            title: Text('Dish ID: $dishId'),
          );
        },
      ),
    );
  }
}

// class favourite_item_screen extends StatelessWidget {
//   const favourite_item_screen({key});
//
//   @override
//   Widget build(BuildContext context) {
//     final FirebaseAuth auth = FirebaseAuth.instance;
//     final User? currentUser = auth.currentUser;
//     final String userId = currentUser?.uid ?? '';
//
//     final favoriteProvider = Provider.of<FavoriteProvider>(context);
//     final favoriteDishes = favoriteProvider.favoriteDishes;
//     return Scaffold(
//       backgroundColor: ColorConstants.grey,
//       appBar: AppBar(
//         elevation: 0,
//         title: Text(
//           "Favourites",
//           style: TextStyle(
//             color: ColorConstants.black,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: ColorConstants.grey,
//         automaticallyImplyLeading: true,
//         iconTheme: IconThemeData(
//           color: ColorConstants.black,
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('Favorites')
//                   .doc(userId)
//                   .collection('Dishes')
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return CircularProgressIndicator();
//                 }
//
//                 final favoriteDishes = snapshot.data!.docs;
//
//                 if (favoriteDishes.isEmpty) {
//                   return Center(
//                     child: Text('No favorite dishes found.'),
//                   );
//                 }
//
//                 return ListView.builder(
//                   padding: EdgeInsets.only(left: 25.w,right: 25.w,),
//                   itemCount: favoriteDishes.length,
//                   itemBuilder: (context, index) {
//                     final dishData = favoriteDishes[index].data() as Map<String, dynamic>;
//                     return Container(
//                       margin: EdgeInsets.only(top: 10.h),
//                       child: Slidable(
//                       closeOnScroll: true,
//                       endActionPane: ActionPane(
//                         extentRatio: 0.3,
//                         motion: const DrawerMotion(),
//                         children: [
//                           SlidableAction(
//                             onPressed: (context) {
//                               showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     contentPadding: EdgeInsets.only(left: 18.w, right: 18.w),
//                                     actions: [
//                                       TextButton(
//                                           style: TextButton.styleFrom(
//                                             foregroundColor: ColorConstants.purple,
//                                           ),
//                                           onPressed: () {
//                                             FirebaseFirestore.instance.collection('Favorites')
//                                                 .doc(favoriteDishes[index].id)
//                                                 .delete();
//                                             Get.back();
//                                           },
//                                           child: Text(
//                                             "Yes",
//                                             style: TextStyle(
//                                               color: Colors.green,
//                                             ),
//                                           )),
//                                       TextButton(
//                                           style: TextButton.styleFrom(
//                                             foregroundColor: ColorConstants.purple,
//                                           ),
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: Text(
//                                             "No",
//                                             style: TextStyle(color: Colors.red),
//                                           )),
//                                     ],
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.all(
//                                         Radius.circular(15),
//                                       ),
//                                     ),
//                                     title: Text(
//                                       'Clearing Basket',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold, fontSize: 16.sp),
//                                     ),
//                                     content: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: <Widget>[
//                                         Image(
//                                             height: 120.h,
//                                             fit: BoxFit.cover,
//                                             image: const AssetImage(
//                                               'assets/images/listening.gif',
//                                             )),
//                                         Container(
//                                           alignment: Alignment.center,
//                                           child: Text(
//                                             'Are you sure you want to continue?',
//                                             style: TextStyle(
//                                                 fontSize: 13.sp, fontWeight: FontWeight.w600),
//                                             textAlign: TextAlign.center,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                             icon: Icons.delete,
//                             backgroundColor: Colors.red,
//                             label: "Delete",
//                             borderRadius: BorderRadius.circular(5),
//                             autoClose: true,
//                           ),
//                         ],
//                       ),
//                       child: Container(
//                         width: 314.w,
//                         height: 105.h,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius:
//                             BorderRadius.circular(10)),
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               left: 15.w, right: 15.w),
//                           child: Row(
//                             children: [
//                               Image(
//                                   width: 80.w,
//                                   height: 80.h,
//                                   fit: BoxFit.cover,
//                                   image: AssetImage(
//                                       ImageConstant.watch)),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 10.w,
//                                     top: 25.h,
//                                     bottom: 23.h),
//                                 child: Column(
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                   MainAxisAlignment
//                                       .spaceBetween,
//                                   children: [
//                                     Text(
//                                       dishData['dishName'],
//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight:
//                                           FontWeight.w600),
//                                     ),
//                                     Text(
//                                       dishData['restaurantName'],
//                                       style: TextStyle(
//                                           fontSize: 13,
//                                           fontWeight:
//                                           FontWeight.w600),
//                                     ),
//                                     Text(
//                                       "\$${dishData['price']}"
//                                           .toString(),
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           fontWeight:
//                                           FontWeight.w600,
//                                           color: ColorConstants
//                                               .purple),
//                                     ),
//                                     Row(
//                                       children: [
//                                         const Text(
//                                           "Quantity",
//                                           style: TextStyle(
//                                               fontSize: 13,
//                                               fontWeight:
//                                               FontWeight
//                                                   .w400),
//                                         ),
//                                         SizedBox(
//                                           width: 10.w,
//                                         ),
//                                         Text(
//                                           dishData['quantity'].toString(),
//                                           style: TextStyle(
//                                               fontSize: 13,
//                                               fontWeight:
//                                               FontWeight
//                                                   .w600),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Column(
// children: [
// const SizedBox(
// height: 40,
// ),
//
// Image(
// image: AssetImage(ImageConstant.favourite),
// ),
// Text(
// "No Favourites Yet",
// style: TextStyle(
// fontSize: 20,
// fontWeight: FontWeight.bold,
// color: ColorConstants.black,
// ),
// ),
// const SizedBox(
// height: 10,
// ),
// const Text(
// "Hit the Orange Button down\n       Below to create Order."),
// const SizedBox(
// height: 20,
// ),
// custom_button(
// label: "Start Adding",
// backgroundcolor: ColorConstants.lightBlue,
// textcolor: ColorConstants.white,
// function: () {
// Get.off(home_screen());
// })
// ],
// ),



// return ListTile(
// title: Text(dishData['dishName']),
// subtitle: Text('Price: \$${dishData['price']}'),
// trailing: IconButton(
// icon: Icon(Icons.delete),
// onPressed: () {
// // Delete the favorite dish from Firestore
// FirebaseFirestore.instance
//     .collection('Favorites')
//     .doc(favoriteDishes[index].id)
//     .delete();
// },
// ),
// );

