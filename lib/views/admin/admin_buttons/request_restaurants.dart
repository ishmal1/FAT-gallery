import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../utils/images/images.dart';
import 'approve_reject_buttons.dart';
import 'delete_button.dart';

class RestaurantCard extends StatelessWidget {
  final QueryDocumentSnapshot restaurants;
  const RestaurantCard({Key? key, required this.restaurants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height / 150),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.06,
                    height: MediaQuery.of(context).size.height / 8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white38,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(AppImages.foodImg))),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 200,
                  ),
                  Text(
                    restaurants['restaurantName'],
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 120,
                  ),
                  Text(
                    restaurants['phoneNumber'],
                    style: TextStyle(fontSize: 11),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 250,
                  ),
                  Text(
                    restaurants['email'],
                    style: TextStyle(fontSize: 11),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 250,
                  ),
                  Text(
                    restaurants['address'],
                    style: TextStyle(fontSize: 11),
                  ),
                  restaurants['status'] == 'Pending'
                      ? RestaurantButtons(
                          restaurants: this.restaurants,
                        )
                      : DeleteRestaurant(
                          restaurants: this.restaurants,
                        )
                ],
              ),
            ],
          )),
    );
  }
}
