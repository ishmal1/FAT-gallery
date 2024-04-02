import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login_signup/firebase/auth_service/auth_service.dart';
import 'package:login_signup/providers/slider_provider.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import '../../../providers/fav_provider.dart';
import '../../../utils/color_constant.dart';
import '../../../widgets/custom_button.dart';
import '../../basket_screen.dart';
import '../../contact_gallery_screen.dart';

class product_info extends StatefulWidget {
  final String restaurantId;
  final String dishId;
  const product_info(
      {Key? key, required this.restaurantId, required this.dishId})
      : super(key: key);

  @override
  State<product_info> createState() => _product_infoState();
}

class _product_infoState extends State<product_info> {
  Future<void> fetchSelectedValues() async {
    // Fetching values from Firestore
    var documentSnapshot = await FirebaseFirestore.instance
        .collection("Dishes")
        .doc(widget.restaurantId)
        .collection("Rest_Dishes")
        .get();

    // Extracting the data from the document snapshot
    List<Map<String, dynamic>> fetchedValues = [];
    documentSnapshot.docs.forEach((doc) {
      fetchedValues.add(doc.data());
    });

    // Accessing the selected values
    List<String> selectedValues = [];
    fetchedValues.forEach((value) {
      if (value.containsKey('selectedValues')) {
        List<dynamic> selectedList = value['selectedValues'];
        selectedList.forEach((selectedItem) {
          selectedValues.add(selectedItem.toString());
        });
      }
    });

    // Now you can use the selectedValues list as needed
    // For example, you can print the selected values
    print(selectedValues);
  }

  Stream<DocumentSnapshot>? _dishStream;
  int _quantity = 1;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _dishStream = FirebaseFirestore.instance
        .collection('Dishes')
        .doc(widget.restaurantId)
        .collection('Rest_Dishes')
        .doc(widget.dishId)
        .snapshots();

    // Check if the dish is already marked as favorite
    _isFavorite = Provider.of<FavoriteProvider>(context, listen: false)
        .isFavorite(widget.dishId);
  }


  void _toggleFavorite() async {
    // setState(() {
    _isFavorite = !_isFavorite;
    // });

    final AuthService authService = Get.find();
    final String userId = authService.currentUser?.uid ?? '';

    final dishSnapshot = await FirebaseFirestore.instance
        .collection('Dishes')
        .doc(widget.restaurantId)
        .collection('Rest_Dishes')
        .doc(widget.dishId)
        .get();

    final restaurantSnapshot = await FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(widget.restaurantId)
        .get();

    final favoriteData = {
      'dishId': widget.dishId,
      'dishName': dishSnapshot['dishName'],
      'price': dishSnapshot['price'],
      'quantity': _quantity,
      'restaurantName': restaurantSnapshot['restaurantName'],
      'images': dishSnapshot['images'],
    };

    final favoriteProvider =
        Provider.of<FavoriteProvider>(context, listen: false);

    final favoriteDishesCollection = FirebaseFirestore.instance
        .collection('Favorites')
        .doc(userId)
        .collection('Dishes'); // Subcollection for favorite dishes

    if (_isFavorite) {
      favoriteProvider.addFavorite(widget.dishId);

      favoriteDishesCollection.doc(widget.dishId).set(favoriteData);
    } else {
      favoriteProvider.removeFavorite(widget.dishId);

      favoriteDishesCollection.doc(widget.dishId).delete();
    }
  }

  Future<List<String>> _loadDishImages() async {
    final dishSnapshot = await FirebaseFirestore.instance
        .collection('Dishes')
        .doc(widget.restaurantId)
        .collection('Rest_Dishes')
        .doc(widget.dishId)
        .get();

    final dishData = dishSnapshot.data() as Map<String, dynamic>;

    List<String> images = [];
    if (dishData.containsKey('images')) {
      images = List<String>.from(dishData['images']);
    }

    return images;
  }

  int currentIndexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.grey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: ColorConstants.black,
        ),
        actions: [
          // IconButton(
          //   icon: Icon(
          //     _isFavorite ? Icons.favorite : Icons.favorite_border,
          //     color: Colors.red,
          //   ),
          //   onPressed: _toggleFavorite,
          // ),
          Consumer<FavoriteProvider>(
            builder: (BuildContext context, favoriteProvider, _) {
              final isFavorite = favoriteProvider.isFavorite(widget.dishId);
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  if (isFavorite) {
                    _toggleFavorite();
                  } else {
                    _toggleFavorite();
                  }
                },
              );
            },
          ),

          // Consumer<FavoriteProvider>(
          //   builder: (BuildContext context, favoriteProvider, _) {
          //     final isFavorite = favoriteProvider.isFavorite(widget.dishId);
          //     return IconButton(
          //       icon: Icon(
          //         isFavorite ? Icons.favorite : Icons.favorite_border,
          //         color: Colors.red,
          //       ),
          //       onPressed: () {
          //         if (isFavorite) {
          //           _toggleFavorite();
          //         } else {
          //           _toggleFavorite();
          //         }
          //       },
          //     );
          //   },
          // ),
        ],
        elevation: 0.0,
        backgroundColor: ColorConstants.grey,
      ),
      body: Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Dishes')
                .doc(widget.restaurantId)
                .collection('Rest_Dishes')
                .doc(widget.dishId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.purple,
                  ),
                );
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
              final dishData = snapshot.data!.data() as Map<String, dynamic>;

              // Extract selected values from dishData
              List<String> selectedValues = [];
              if (dishData.containsKey('selectedValues')) {
                selectedValues = List<String>.from(dishData['selectedValues']);
              }
              List<String> images = [];
              if (dishData.containsKey('images')) {
                images = List<String>.from(dishData['images']);
              }

              return Expanded(
                child: ChangeNotifierProvider<SliderProvider>(
                  create: (_) => SliderProvider(),
                  child: Column(
                    children: [
                      Consumer<SliderProvider>(
                        builder: (context, carouselState, _) {
                          return CarouselSlider(
                            items: images
                                .map((url) => FullScreenWidget(
                                    disposeLevel: DisposeLevel.Low,
                                    child: ImageItem(url: url)))
                                .toList(),
                            options: CarouselOptions(
                              height: 160.h,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              viewportFraction: 0.8,
                              onPageChanged: (index, _) {
                                carouselState.setCurrentIndex(index);
                              },
                            ),
                          );
                        },
                      ),
                      Consumer<SliderProvider>(
                          builder: (context, carouselState, _) {
                        return DotsIndicator(
                          dotsCount: images.length,
                          position: carouselState.currentIndex,
                          decorator: DotsDecorator(
                            activeColor: ColorConstants.purple,
                            size: const Size.square(9.0),
                            activeSize: const Size(18.0, 9.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        );
                      }),
                      Expanded(
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          color: ColorConstants.white,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 25.w,
                              right: 25.w,
                              top: 10.h
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        dishData['dishName'],
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        '${dishData['discount']}% off',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 9.h,
                                  ),
                                  Center(
                                    child: custom_button(
                                      function: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                                      },
                                      label: 'Contact Gallery',
                                      backgroundcolor: Colors.black,
                                      textcolor: ColorConstants.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 18.h,
                                  ),
                                  Text(
                                    "Category",
                                    style: TextStyle(
                                      fontSize: 13.h,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 9.h,
                                  ),
                                  Wrap(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          selectedValues.contains("Oil Paint")
                                              ? chips(
                                                  color: ColorConstants.skyblue,
                                                  text: "Oil Paint",
                                                )
                                              : Container(),
                                          selectedValues.contains("Oil Paint")
                                              ? chips(
                                                  color:
                                                      ColorConstants.rosegold,
                                                  text: "NFT",
                                                )
                                              : Container(),
                                          selectedValues.contains("Sketch")
                                              ? chips(
                                                  color: ColorConstants.green,
                                                  text: "Sketch",
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 7.h),
                                      child: Text(
                                        "persona-04 (NFT), ${dishData['year']}",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 13.h,
                                  ),
                                  Text(
                                    "Description",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                              ReadMoreText(
                                // "The androidNotificationDetail and iOSNotification detail contain settings such as enabling/disabling badge, sound etc.Android specifically requires you to define channels to distinguish between various notifications.Pass on this setting along with id(0 in our example), title and body to show the method of FlutterLocalNotification.Id is used to identify a notification just in case we want to cancel. Cancelling notifications will be covered in later publications.",
                                dishData['description'],
                                trimLines: 5,
                                style: TextStyle(fontSize: 10.sp),
                                colorClickableText: ColorConstants.purple,
                                trimMode: TrimMode.Line,
                                textAlign: TextAlign.justify,
                                trimCollapsedText: ' Show more',
                                trimExpandedText: ' Show less',

                                moreStyle: TextStyle(color: ColorConstants.purple,fontWeight: FontWeight.w600),
                                lessStyle: TextStyle(color: ColorConstants.purple,fontWeight: FontWeight.w600)),

                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: <Widget>[
                                  //     TextButton(
                                  //       onPressed: () {},
                                  //       child: const Text(
                                  //         "Full description",
                                  //         style: TextStyle(
                                  //           fontSize: 15,
                                  //           fontWeight: FontWeight.bold,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Icon(
                                  //       Icons.arrow_forward,
                                  //       color: ColorConstants.purple,
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: 18.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Total",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              // color: ColorConstants.purple,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "\$${dishData['price']}".toString(),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConstants.purple,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: custom_button(
                                        function: () {

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BasketScreen(
                                                dishId: widget.dishId,
                                                restaurantId:
                                                    widget.restaurantId,
                                              ),
                                            ),
                                          );
                                        },
                                        label: 'Add to basket',
                                        backgroundcolor: ColorConstants.purple,
                                        textcolor: ColorConstants.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class chips extends StatelessWidget {
  chips({key, required this.color, required this.text});

  Color color;
  String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width / 3.8,
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: ColorConstants.grey),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Chip(
          elevation: 0.0,
          padding: EdgeInsets.only(left: 5.w,right: 5.w,top: 5.h,bottom: 5.h),
          backgroundColor: ColorConstants.white,
          shadowColor: Colors.black,
          avatar: CircleAvatar(
            backgroundColor: color,
          ),
          label: Text(
            text,
            // ignore: prefer_const_constructors
            style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.bold),
          ), //Text
        ),
      ),
    );
  }
}

class ImageItem extends StatelessWidget {
  final String url;

  const ImageItem({required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.only(left: 4.w,right: 4.w,top: 4.h,bottom: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: CachedNetworkImageProvider(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
