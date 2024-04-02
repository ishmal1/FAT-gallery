import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login_signup/widgets/form_fields.dart';

import '../../../../utils/color_constant.dart';
import '../components/product_card.dart';
import '../models/product.dart';
import '../utils/image_constant.dart';
import '../views/products_pages/dishes/product_list.dart';
import 'custom_tab_bar.dart';

class home_screen_Component extends StatefulWidget {
  const home_screen_Component({key});

  @override
  State<home_screen_Component> createState() => _home_screen_ComponentState();
}

class _home_screen_ComponentState extends State<home_screen_Component>
    with SingleTickerProviderStateMixin {
  late TabController? tabController;
  late Stream<QuerySnapshot>? _stream;
  List<DocumentSnapshot> filteredRestaurants = [];
  List<String> contentList = ['Sketch', 'Paint', 'Painting', 'NFT\s'];
  // Initialize as an empty list
  late List<DocumentSnapshot> restaurants;
  double ratingValue = 0;

  bool seemore = true;
  void SeeMore() {
    setState(() {
      seemore = !seemore;
    });
  }

  final double circleRadius = 90.r;
  final double circleBorderWidth = 1.w;

  TextEditingController _searchController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  String _searchQuery = '';

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, initialIndex: 0, vsync: this);
    _stream = FirebaseFirestore.instance.collection('Restaurants').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.grey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 15.w, right: 15.w, bottom: 7.h, top: 7.h),
            child: TextFormField(
              style: TextStyle(fontSize: 14.sp),
              controller: _searchController,
              onChanged: (query) => _performSearch(query),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: ColorConstants.black,
                  ),
                  hintText: 'Search...',
                  helperStyle: TextStyle(
                    fontSize: 14.sp
                  ),
                  hintStyle: const TextStyle(fontWeight: FontWeight.w600),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear,size: 22.sp,),
                    onPressed: () {
                      _searchController.clear();
                      _performSearch('');
                    },
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.w, top: 5.h),
            child: Text(
              "Order online\ncollect in Store",
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: TabBar(
              controller: tabController,
              unselectedLabelColor: ColorConstants.black,
              labelColor: ColorConstants.purple,
              indicatorColor: ColorConstants.purple,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
              tabs: contentList.map((content) {
                return Tab(
                  text: content,
                );
              }).toList(),
              onTap: (index) {
                String selectedContent = contentList[index];

                setState(() {
                  filteredRestaurants = restaurants.where((restaurant) {
                    final content = restaurant.get('content') as List<dynamic>?;
                    return content != null && content.contains(selectedContent);
                  }).toList();
                });

                // Example: Print the filtered restaurant names
                for (final restaurant in filteredRestaurants) {
                  final name = restaurant.get('restaurantName');
                  print('Filtered Restaurant: $name');
                }
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _stream,
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

                restaurants = snapshot.data!.docs;

                // Clear the list before populating it
                contentList.clear();

                for (final restaurant in restaurants) {
                  final content = restaurant.get('content') as List<dynamic>?;
                  if (content != null) {
                    for (final item in content) {
                      if (item is String && !contentList.contains(item)) {
                        contentList.add(item);
                      }
                    }
                  }
                }

                if (contentList.isEmpty) {
                  return const Center(
                    child: Text('No content available.'),
                  );
                }

                // Populate the 'filteredRestaurants' list
                String selectedContent =
                    contentList[0]; // Assuming initial index is 0

                filteredRestaurants = restaurants.where((restaurant) {
                  final content = restaurant.get('content') as List<dynamic>?;
                  return content != null && content.contains(selectedContent);
                }).toList();

                return TabBarView(
                  controller: tabController,
                  children: contentList.map((content) {
                    final filteredList = restaurants.where((restaurant) {
                      final contentData =
                          restaurant.get('content') as List<dynamic>?;
                      return contentData != null &&
                          contentData.contains(content);
                    }).toList();

                    return StreamBuilder<QuerySnapshot>(
                      // stream: FirebaseFirestore.instance.collection('Restaurants').where("status", isEqualTo: "Approved").snapshots(),
                      stream: FirebaseFirestore.instance
                          .collection('Restaurants')
                          .where("status", isEqualTo: "Approved")
                          .where('restaurantName',
                              isGreaterThanOrEqualTo: _searchQuery)
                          .where('restaurantName',
                              isLessThan: _searchQuery + 'z')
                          .snapshots(),
                      builder: (context, restaurantSnapshot) {
                        if (restaurantSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                                  color: ColorConstants.purple));
                        }
                        if (restaurantSnapshot.hasError) {
                          return const Center(
                            child: Text('Snapshot error'),
                          );
                        }
                        if (!restaurantSnapshot.hasData) {
                          return const Center(
                            child: Text('Snapshot data missing'),
                          );
                        }
                        final restaurants = restaurantSnapshot.data!.docs;
                        final filteredRestaurants = restaurants
                          ..where((restaurant) => restaurant['address']
                                  .toLowerCase()
                                  .contains(_searchQuery.toLowerCase()))
                              .where((restaurant) =>
                                  restaurant['restaurantName']
                                      .toLowerCase()
                                      .contains(_searchQuery.toLowerCase()))
                              .toList();

                        return GridView.builder(
                          itemCount: filteredList.length,
                          scrollDirection: (seemore == true)
                              ? Axis.horizontal
                              : Axis.vertical,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: (seemore == true) ? 240.w : 230.w,
                            crossAxisCount: (seemore == true) ? 1 : 2,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            if (index >= filteredRestaurants.length) {
                              return const SizedBox(); // Or any placeholder widget
                            }

                            final restaurant = filteredRestaurants[index].data()
                                as Map<String, dynamic>;
                            // final restaurant = restaurants[index].data() as Map<String, dynamic>;
                            return Padding(
                              padding: EdgeInsets.only(
                                left: (seemore == true) ? 0 : 7.w,
                                right: (seemore == true) ? 0 : 7.w,
                              ),
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  alignment: Alignment.center,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Center(
                                      child: Padding(
                                        padding: (seemore == true)
                                            ? EdgeInsets.only(left: 30.w)
                                            : EdgeInsets.only(
                                                left: 10.w,
                                                right: 10.w,
                                              ),
                                        child: Stack(
                                          alignment: Alignment.topCenter,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: circleRadius / 1.5),
                                              child: Container(
                                                color: Colors.transparent,
                                                width: Get.width / 2,
                                                height: Get.height / 4.15,
                                                child: InkWell(
                                                  onTap: () {

                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  product_list(
                                                                    restaurantId:
                                                                        filteredRestaurants[index]
                                                                            .id,
                                                                  )),
                                                    );
                                                    final userId = FirebaseAuth.instance.currentUser?.uid;

                                                    // final userId = FirebaseAuth.instance.currentUser?.uid;
                                                    if (userId != null) {
                                                      final restaurantId =
                                                          filteredRestaurants[
                                                                  index]
                                                              .id;
                                                      final searchCollectionRef = FirebaseFirestore.instance.collection('SearchCollection').doc(userId).collection("Gallery");

                                                      searchCollectionRef
                                                          .where('restaurantId',
                                                              isEqualTo:
                                                                  restaurantId)
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
                                                            'restaurantId': filteredRestaurants[index].id,
                                                            "userId": userId,
                                                            'viewed': true,
                                                            'timestamp':
                                                            DateTime.now(),
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
                                                  child: Card(
                                                    surfaceTintColor: Colors.white,

                                                    elevation: 10,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 5.h,
                                                                  right: 2.w),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  print(filteredRestaurants[
                                                                          index]
                                                                      .id);
                                                                  bool
                                                                      submitting =
                                                                      false;
                                                                  return StatefulBuilder(
                                                                    builder: (context,
                                                                            setState) =>
                                                                        CupertinoAlertDialog(
                                                                      title:
                                                                          Column(
                                                                        children: <Widget>[
                                                                          Text(
                                                                            "Rate Us",
                                                                            style:
                                                                                TextStyle(color: Colors.black),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10.h), // Add some spacing between the rating bar and the text field
                                                                          RatingBar
                                                                              .builder(
                                                                            initialRating:
                                                                                0,
                                                                            minRating:
                                                                                1,
                                                                            direction:
                                                                                Axis.horizontal,
                                                                            allowHalfRating:
                                                                                true,
                                                                            itemCount:
                                                                                5,
                                                                            itemSize:
                                                                                22.sp,
                                                                            itemBuilder: (context, _) =>
                                                                                Icon(
                                                                              Icons.star,
                                                                              color: Colors.amber,
                                                                            ),
                                                                            onRatingUpdate:
                                                                                (rating) {
                                                                              print(rating);
                                                                              ratingValue = rating;
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10.h), // Add some spacing between the rating bar and the text field
                                                                          CupertinoTextField(
                                                                            controller:
                                                                                rateController,
                                                                            maxLines:
                                                                                3,
                                                                            maxLength:
                                                                                30,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            placeholder:
                                                                                "Enter your feedback",
                                                                            // Customize other properties of the text field as needed
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      actions: <Widget>[
                                                                        CupertinoDialogAction(
                                                                          child: submitting
                                                                              ? CircularProgressIndicator()
                                                                              : Text(
                                                                                  "Submit",
                                                                                  style: TextStyle(color: Colors.black),
                                                                                ),
                                                                          onPressed: submitting
                                                                              ? null
                                                                              : () async {
                                                                                  setState(() {
                                                                                    submitting = true;
                                                                                  });

                                                                                  // Simulate a delay of 2 seconds
                                                                                  await Future.delayed(Duration(seconds: 2));

                                                                                  // Store the rating and feedback in Firebase
                                                                                  FirebaseFirestore.instance.collection('Rate Us').doc(filteredRestaurants[index].id).set({
                                                                                    'rating': ratingValue,
                                                                                    'feedback': rateController.text,
                                                                                    "restaurantId": filteredRestaurants[index].id,
                                                                                  }).then((_) {
                                                                                    // Rating and feedback successfully stored in Firebase
                                                                                    Navigator.pop(context);
                                                                                    showDialog(
                                                                                      context: context,
                                                                                      builder: (context) => CupertinoAlertDialog(
                                                                                        title: Text(
                                                                                          "Success",
                                                                                          style: TextStyle(color: Colors.black),
                                                                                        ),
                                                                                        content: Text("Your response has been submitted."),
                                                                                        actions: <Widget>[
                                                                                          CupertinoDialogAction(
                                                                                            child: Text(
                                                                                              "OK",
                                                                                              style: TextStyle(color: Colors.black),
                                                                                            ),
                                                                                            onPressed: () {
                                                                                              Navigator.pop(context);
                                                                                            },
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    );
                                                                                  }).catchError((error) {
                                                                                    // An error occurred while storing the rating and feedback
                                                                                    print("Error: $error");
                                                                                    Navigator.pop(context);
                                                                                  });
                                                                                },
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child: Icon(Icons
                                                                    .more_vert,size: 22.sp,)),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: (seemore ==
                                                                          true)
                                                                      ? 45.h
                                                                      : 23.h),
                                                          child: Column(
                                                            children: <Widget>[
                                                              SizedBox(
                                                                height: 3.h,
                                                              ),
                                                              Text(
                                                                restaurant[
                                                                    'restaurantName'],
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline,
                                                                    fontSize:
                                                                        16.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                              SizedBox(
                                                                height: 1.h,
                                                              ),
                                                              Text(
                                                                restaurant[
                                                                    'email'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Text(
                                                                restaurant[
                                                                    'address'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: ColorConstants
                                                                        .purple),
                                                              ),
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                              Padding(
                                                                padding: (seemore ==
                                                                        true)
                                                                    ? EdgeInsets.only(
                                                                        left: 70
                                                                            .w,
                                                                        right:
                                                                            5.w)
                                                                    : EdgeInsets.only(
                                                                        left: 50
                                                                            .w,
                                                                        right: 5
                                                                            .w),
                                                                child:
                                                                    RatingBarIndicator(
                                                                  rating: 2.75,
                                                                  itemBuilder:
                                                                      (context,
                                                                              index) =>
                                                                          Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .amber,
                                                                  ),
                                                                  itemCount: 5,
                                                                  itemSize:
                                                                      (seemore ==
                                                                              true)
                                                                          ? 17
                                                                          : 15,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            (seemore == true)
                                                ? Container(
                                                    width: 130.w,
                                                    height: 130.h,
                                                    decoration:
                                                        const ShapeDecoration(
                                                            shape:
                                                                CircleBorder(),
                                                            color: Colors
                                                                .transparent),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          circleBorderWidth),
                                                      child: DecoratedBox(
                                                        decoration: ShapeDecoration(
                                                            shape:
                                                                const CircleBorder(),
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: CachedNetworkImageProvider(
                                                                    restaurant[
                                                                        'image_url']))),
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    width: 100.w,
                                                    height: 90.h,
                                                    margin: EdgeInsets.only(
                                                        top: 10.h),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          circleBorderWidth),
                                                      child: DecoratedBox(
                                                        decoration: ShapeDecoration(
                                                            shape:
                                                                RoundedRectangleBorder(),
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: CachedNetworkImageProvider(
                                                                    restaurant[
                                                                        'image_url']))),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      SeeMore();
                    },
                    child: Text(
                      (seemore == true) ? "See More" : "Show Less",
                      style: TextStyle(
                          color: ColorConstants.purple,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700),
                    )),
                Icon(
                  Icons.arrow_forward_outlined,
                  color: ColorConstants.purple,
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
