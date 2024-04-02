import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/color_constant.dart';
import '../views/products_pages/dishes/product_list.dart';

class custom_tab_Bar extends StatefulWidget {
  const custom_tab_Bar({key});

  @override
  State<custom_tab_Bar> createState() => _custom_tab_BarState();
}

class _custom_tab_BarState extends State<custom_tab_Bar> with SingleTickerProviderStateMixin{
  late TabController? tabController;
  late Stream<QuerySnapshot>? _stream;
  List<DocumentSnapshot> filteredRestaurants = [];
  List<String> contentList = ['Sketch', 'Paint', 'Painting', 'NFT\s'];
  // Initialize as an empty list
  late List<DocumentSnapshot> restaurants;

  bool seemore = true;
  void SeeMore() {
    setState(() {
      seemore = !seemore;
    });
  }
  final double circleRadius = 100.0;
  final double circleBorderWidth = 2.0;

  TextEditingController _searchController = TextEditingController();
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
            padding:
            const EdgeInsets.only(left: 20.0, right: 20, bottom: 10, top: 10),
            child: TextFormField(
              controller: _searchController,
              onChanged: (query) => _performSearch(query),
              decoration: InputDecoration(

                  prefixIcon: Icon(
                    Icons.search,
                    color: ColorConstants.black,
                  ),
                  hintText: 'Search...',
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w600
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      _performSearch('');
                    },),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30,top: 5),
            child: Text(
              "Order online\ncollect in Store",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          TabBar(
            controller: tabController,
            unselectedLabelColor: ColorConstants.black,
            labelColor: ColorConstants.purple,
            indicatorColor: ColorConstants.purple,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.9,
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
          const SizedBox(
            height: 20,
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
                String selectedContent = contentList[0]; // Assuming initial index is 0

                filteredRestaurants = restaurants.where((restaurant) {
                  final content = restaurant.get('content') as List<dynamic>?;
                  return content != null && content.contains(selectedContent);
                }).toList();

                return TabBarView(
                  controller: tabController,
                  children: contentList.map((content) {
                    final filteredList = restaurants.where((restaurant) {
                      final contentData = restaurant.get('content') as List<dynamic>?;
                      return contentData != null && contentData.contains(content);
                    }).toList();

                    return StreamBuilder<QuerySnapshot>(
                      // stream: FirebaseFirestore.instance.collection('Restaurants').where("status", isEqualTo: "Approved").snapshots(),
                      stream: FirebaseFirestore.instance.collection('Restaurants')
                          .where("status", isEqualTo: "Approved")
                          .where('restaurantName', isGreaterThanOrEqualTo: _searchQuery)
                          .where('restaurantName', isLessThan: _searchQuery + 'z')
                          .snapshots(),
                      builder: (context, restaurantSnapshot) {
                        if (restaurantSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator(color: ColorConstants.purple));
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
                        final filteredRestaurants = restaurants..where((restaurant) => restaurant['address'].toLowerCase().contains(_searchQuery.toLowerCase()))
                            .where((restaurant) => restaurant['restaurantName'].toLowerCase().contains(_searchQuery.toLowerCase()))
                            .toList();

                        return GridView.builder(
                          itemCount: filteredList.length,
                          scrollDirection: (seemore == true) ? Axis.horizontal : Axis.vertical,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: (seemore == true) ? 250 : 240,
                              crossAxisCount: (seemore == true) ? 1 : 2,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            if (index >= filteredRestaurants.length) {
                              return const SizedBox(); // Or any placeholder widget
                            }

                            final restaurant = filteredRestaurants[index].data() as Map<String, dynamic>;
                            // final restaurant = restaurants[index].data() as Map<String, dynamic>;
                            return Padding(
                              padding: EdgeInsets.only(
                                left: (seemore == true) ? 0 : 10,
                                right: (seemore == true) ? 0 : 10,),
                              child: GestureDetector(
                                onTap: () {
                                  },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Center(
                                      child: Padding(
                                        padding: (seemore == true) ? EdgeInsets.only(left: 30.w) : EdgeInsets.only(left: 10.w,right: 10.w),
                                        child: Stack(
                                          alignment: Alignment.topCenter,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(top: circleRadius / 1.5),
                                              child: Container(
                                                color: Colors.transparent,
                                                width: Get.width / 2,
                                                height: Get.height / 4.2,
                                                child: InkWell(
                                                  onTap: (){
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => product_list(restaurantId: filteredRestaurants[index].id,))
                                                    );
                                                  },
                                                  child: Card(
                                                    elevation: 10,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15.0),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(top: (seemore == true) ? 70.h : 40.h),
                                                      child: Column(
                                                        children: <Widget>[
                                                          SizedBox(height: 3.h,),
                                                          Text(
                                                            restaurant['restaurantName'],
                                                            style: TextStyle(
                                                                fontSize: 15.sp, fontWeight: FontWeight.w600),
                                                          ),
                                                          SizedBox(height: 1.h,),
                                                          Text(
                                                            restaurant['email'],
                                                            style: TextStyle(
                                                              fontSize: 12.sp,
                                                                fontWeight: FontWeight.w400
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text(
                                                            restaurant['phoneNumber'],
                                                            style: TextStyle(
                                                                fontSize: 14.sp,
                                                                fontWeight: FontWeight.bold,
                                                                color: ColorConstants.purple),
                                                          ),
                                                          SizedBox(
                                                        height: 10.h,
                                                      ),
                                                          Padding(
                                                            padding: (seemore == true) ? EdgeInsets.only(left: 70.w,right: 5.w) : EdgeInsets.only(left: 50.w,right: 5.w),
                                                            child: RatingBarIndicator(
                                                              rating: 2.75,
                                                              itemBuilder: (context, index) => Icon(
                                                                Icons.star,
                                                                color: Colors.amber,
                                                              ),
                                                              itemCount: 5,
                                                              itemSize: (seemore == true) ? 17 : 15,
                                                              direction: Axis.horizontal,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            (seemore == true) ? Container(
                                              width: 130.w,
                                              height: 130.h,
                                              decoration: const ShapeDecoration(
                                                  shape: CircleBorder(), color: Colors.transparent),
                                              child: Padding(
                                                padding: EdgeInsets.all(circleBorderWidth),
                                                child: DecoratedBox(
                                                  decoration: ShapeDecoration(
                                                      shape: const CircleBorder(),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: CachedNetworkImageProvider(restaurant['image_url']))),
                                                ),
                                              ),
                                            ) : Container(
                                              width: 100.w,
                                              height: 100.h,
                                              child: Padding(
                                                padding: EdgeInsets.all(circleBorderWidth),
                                                child: DecoratedBox(
                                                  decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: CachedNetworkImageProvider(restaurant['image_url']))),
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
                          },);
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
                      style:
                      TextStyle(color: ColorConstants.purple, fontSize: 15,fontWeight: FontWeight.w700),
                    )),
                Icon(
                  Icons.arrow_forward_outlined,
                  color: ColorConstants.purple,
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
