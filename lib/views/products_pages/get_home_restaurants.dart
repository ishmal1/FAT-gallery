import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/images/images.dart';
import '../../utils/color_constant.dart';
import '../../utils/image_constant.dart';

class GetHomeRestaurants extends StatelessWidget {
  final double circleRadius = 100.0;
  final double circleBorderWidth = 2.0;

  final String documentId;

  var collection = FirebaseFirestore.instance.collection("Restaurants");

  GetHomeRestaurants({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference restaurants =
    FirebaseFirestore.instance.collection("Restaurants");

    return FutureBuilder<DocumentSnapshot>(
        future: restaurants.doc(documentId).get(),
        builder: ((context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            Map<String, dynamic> data = snapshot.data!.data() as Map<String,dynamic>;
            return Center(
              child: Padding(
                padding: EdgeInsets.only(left: 30),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: circleRadius / 2.0),
                      child: Container(
                        color: Colors.transparent,
                        width: Get.width / 2,
                        height: Get.height / 3.4,
                        child: InkWell(
                          onTap: () {
                            // Get.to(product_info());
                          },
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 90),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    data['restaurantName'],
                                    style: TextStyle(
                                        fontSize: 22, fontWeight: FontWeight.w500),
                                  ),
                                   Text(
                                    data['email'],
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      data['phoneNumber'],
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: ColorConstants.purple),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 160,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(circleBorderWidth),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    ImageConstant.watch,
                                  ))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
            // return Card(
            //   child: Container(
            //     alignment: Alignment.center,
            //       padding: EdgeInsets.all(MediaQuery.of(context).size.height / 150),
            //       child: Column(
            //         children: [
            //           Container(
            //             width: MediaQuery.of(context).size.width / 2.34,
            //             margin: EdgeInsets.all(MediaQuery.of(context).size.width / 200),
            //             height: MediaQuery.of(context).size.height / 8,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10),
            //                 color: Colors.white38,
            //                 image: DecorationImage(
            //                     fit: BoxFit.cover,
            //                     image: AssetImage(AppImages.foodImg))),
            //           ),
            //           SizedBox(height: MediaQuery.of(context).size.height / 200,),
            //           Text(data['restaurantName'], style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12),),
            //           SizedBox(height: MediaQuery.of(context).size.height / 120,),
            //           Text(data['phoneNumber'],style: TextStyle(fontSize: 11),),
            //           SizedBox(height: MediaQuery.of(context).size.height / 250,),
            //           Text(data['email'],style: TextStyle(fontSize: 11),),
            //           SizedBox(height: MediaQuery.of(context).size.height / 250,),
            //           Text(data['address'],style: TextStyle(fontSize: 11),),
            //         ],
            //
            //
            //
            //       )
            //   ),
            // );
          }
          return Container(
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              clipBehavior: Clip.none,
              title: Center(
                child: CircularProgressIndicator(
                  color: ColorConstants.purple,
                ),
              ),
            ),
          );
          //   Card(
          //   child: Container(
          //       padding: EdgeInsets.all(MediaQuery.of(context).size.height / 90),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text("Name", style: TextStyle(fontWeight: FontWeight.w700),),
          //               SizedBox(height: MediaQuery.of(context).size.height / 90,),
          //               Text("RestaurantAddress"),
          //               SizedBox(height: MediaQuery.of(context).size.height / 250,),
          //               Text("Phone"),
          //               SizedBox(height: MediaQuery.of(context).size.height / 250,),
          //               Text("Email"),
          //             ],
          //           ),
          //           Row(
          //             children: [
          //               IconButton(onPressed: (){
          //
          //               }, icon: Icon(Icons.check, color: Colors.green,)),
          //               IconButton(onPressed: (){}, icon: Icon(Icons.close, color: Colors.red,)),
          //             ],
          //           )
          //         ],
          //       )
          //   ),
          // );;

        }));
  }
}
