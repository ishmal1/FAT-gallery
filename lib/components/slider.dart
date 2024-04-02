// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:get/get.dart';
//
// import '../../../../utils/image_constant.dart';
// import '../utils/color_constant.dart';
//
// class slider extends StatelessWidget {
//   final String restaurantId;
//   final String dishId;
//
//   const slider({
//     required this.restaurantId,
//     required this.dishId,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<DocumentSnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('Dishes')
//           .doc(restaurantId)
//           .collection('Rest_Dishes')
//           .doc(dishId)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(
//               color: ColorConstants.purple,
//             ),
//           );
//         }
//         if (snapshot.hasError) {
//           return const Center(
//             child: Text('Snapshot error'),
//           );
//         }
//         if (!snapshot.hasData) {
//           return const Center(
//             child: Text('Snapshot data missing'),
//           );
//         }
//         final dishData = snapshot.data!.data() as Map<String, dynamic>;
//
//         // Fetch images from the dishData collection
//         List<String> images = [];
//         if (dishData.containsKey('images')) {
//           images = List<String>.from(dishData['images']);
//         }
//
//         return CarouselSlider(
//           items: images.map((url) => ImageItem(url: url)).toList(),
//           options: CarouselOptions(
//             height: 200.0,
//             enlargeCenterPage: true,
//             autoPlay: true,
//             aspectRatio: 16 / 9,
//             autoPlayCurve: Curves.fastOutSlowIn,
//             enableInfiniteScroll: true,
//             autoPlayAnimationDuration: const Duration(milliseconds: 800),
//             viewportFraction: 0.8,
//           ),
//         );
//       },
//     );
//   }
// }
// //
// // class ImageItem extends StatelessWidget {
// //   final String url;
// //
// //   const ImageItem({required this.url});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       width: Get.width,
// //       margin: const EdgeInsets.all(6.0),
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(8.0),
// //       ),
// //       child: CachedNetworkImage(
// //         imageUrl: url,
// //         fit: BoxFit.cover,
// //         placeholder: (context, url) => CircularProgressIndicator(
// //           color: ColorConstants.purple,
// //         ),
// //         errorWidget: (context, url, error) => Icon(Icons.error),
// //         cacheManager: DefaultCacheManager(),
// //       ),
// //     );
// //   }
// // }
//
//
