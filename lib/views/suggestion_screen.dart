import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:full_screen_image/full_screen_image.dart';

import '../constants/big_text.dart';
import '../constants/small_text.dart';
import '../utils/color_constant.dart';
import '../utils/image_constant.dart';

class SearchResultsPage extends StatefulWidget {
  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  String? selectedRestaurantId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommended For You'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Gallery'),
            Tab(text: 'Arts'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRestaurantsTab(userId),
          _buildDishesTab(userId, selectedRestaurantId),
        ],
      ),
    );
  }

  Widget _buildRestaurantsTab(String? userId) {
    if (userId == null) {
      return const Center(child: Text('User not signed in'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('SearchCollection')
          .doc(userId)
          .collection('Gallery')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No restaurants found'));
        }

        final restaurants = snapshot.data!.docs;

        return ListView.builder(
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            print(selectedRestaurantId);
            final restaurantData =
            restaurants[index].data() as Map<String, dynamic>;
            final restaurantId = restaurantData['restaurantId'];

            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('Restaurants')
                  .doc(restaurantId)
                  .get(),
              builder: (context, restaurantSnapshot) {
                if (restaurantSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const SizedBox(); // Replace with your loading widget
                }

                if (restaurantSnapshot.hasError) {
                  return const SizedBox(); // Replace with your error widget
                }

                if (!restaurantSnapshot.hasData) {
                  return const SizedBox(); // Replace with your empty data widget
                }

                final restaurant =
                restaurantSnapshot.data!.data() as Map<String, dynamic>;
                return ListTile(
                  leading: Container(
                    width: 60.w,
                    height: 60.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: restaurant['image_url'] ?? '',
                        placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(restaurant['restaurantName'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                  subtitle: Text(restaurant['address'],style: TextStyle(color: ColorConstants.purple,fontWeight: FontWeight.w400,fontSize: 10.sp),),
                  onTap: () {
                    setState(() {
                      selectedRestaurantId = restaurantId; // Store the selected restaurantId
                      _tabController?.animateTo(1);
                    });
                    // Handle restaurant selection and navigate to dishes page
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => _buildDishesTab(userId, restaurantId),
                    //   ),
                    // );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildDishesTab(String? userId, String? restaurantId) {
    if (userId == null) {
      return const Center(child: Text('User not signed in'));
    }

    if (restaurantId == null) {
      return const Center(child: Text('No restaurant selected'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('SearchCollection')
          .doc(userId)
          .collection('Arts')
          .where('restaurantId', isEqualTo: restaurantId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No dishes found'));
        }

        final dishes = snapshot.data!.docs;

        return ListView.builder(
          itemCount: dishes.length,
          itemBuilder: (context, index) {
            final dishData = dishes[index].data() as Map<String, dynamic>;
            final dishId = dishData['dishId'] as String?;

            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('Dishes')
                  .doc(restaurantId)
                  .collection('Rest_Dishes')
                  .doc(dishId)
                  .get(),
              builder: (context, dishSnapshot) {
                if (dishSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const SizedBox(); // Replace with your loading widget
                }

                if (dishSnapshot.hasError) {
                  return const SizedBox(); // Replace with your error widget
                }

                if (!dishSnapshot.hasData) {
                  return const SizedBox(); // Replace with your empty data widget
                }

                final dishDetails = dishSnapshot.data!.data() as Map<String, dynamic>;
                final dishImages = dishDetails['images'] as List<dynamic>?;
                final dishName = dishDetails['dishName'] as String?;
                final dishPrice = dishDetails['price'] as String?;
                final dishDiscount = dishDetails['discount'] as String?;

                // Fetch only the first image
                final firstImage = dishImages?.firstWhere((image) => image is String, orElse: () => null) as String?;

                return ListTile(
                  contentPadding: EdgeInsets.only(right: 20.w,left: 20.w,top: 5.h),
                  leading: Container(
                    width: 60.w,
                    height: 60.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: firstImage ?? '', // Provide a default value or handle the null case
                        placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(dishName ?? '',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                  subtitle: Text('\$ ${dishPrice}',style: TextStyle(color: ColorConstants.purple,fontWeight: FontWeight.w600,fontSize: 11.sp),),
                  trailing: Text('${dishDiscount}% off'),// Provide a default value or handle the null case
                  onTap: () {
                    // Handle dish selection and navigate to dish details page
                  },
                );
              },
            );
          },
        );
      },
    );
  }


}
