import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/firebase/auth_service/auth_service.dart';
import '../../../constants/big_text.dart';
import '../../../constants/small_text.dart';
import '../../../firebase/firestore_fetch_data/fetch_user_data.dart';
import '../../../utils/images/images.dart';
import '../../detail/dish_details.dart';
import 'delete_button_dishes.dart';

class DishesCard extends StatelessWidget {
  final QueryDocumentSnapshot dishes;
  final String restID;
  DishesCard({Key? key, required this.dishes, required this.restID})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DishDetails()));
      },
      child: Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.width / 50),
        child: Row(
          children: [
            //food image of item 1
            Container(
              width: MediaQuery.of(context).size.width / 3.5,
              height: MediaQuery.of(context).size.height / 8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white38,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(AppImages.foodImg))),
            ),
            //details of item  1
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height / 8,
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
                        height: 5,
                      ),
                      Expanded(
                        child: BigText(
                          text: dishes['dishName'],
                          color: Colors.black,
                          size: MediaQuery.of(context).size.width / 23,
                        ),
                      ),

                      Expanded(
                        child: SmallText(
                          text: dishes['detail'],
                          size: MediaQuery.of(context).size.width / 39,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 99,
                      ),
                      Text(
                        dishes['price'],
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize:
                            MediaQuery.of(context).size.width / 25,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Roboto"),
                      ),
                      SizedBox(
                        height: 5,
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
              ),
            )
          ],
        ),
      ),
    );


  }
}