import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../utils/color_constant.dart';
import '../../controller/product_controller.dart';
import '../../utils/image_constant.dart';

class ViewProducts extends StatefulWidget {
  const ViewProducts({Key? key}) : super(key: key);

  @override
  State<ViewProducts> createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {
  final ProductController productController = ProductController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.grey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorConstants.black),
        backgroundColor: ColorConstants.grey,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Listed Product",
          style: TextStyle(
            color: ColorConstants.black,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: productController.getStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text("Loading"));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(ImageConstant.avatar),
                        ),
                        ListTile(
                          title: Text(snapshot.data!.docs[index]['title']),
                          subtitle:
                              Text(snapshot.data!.docs[index]['description']),
                          trailing: const Icon(Icons.star),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: ImageIcon(
                                AssetImage(ImageConstant.delete),
                                color: ColorConstants.darkgrey,
                                size: 24,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: ImageIcon(
                                AssetImage(ImageConstant.edit),
                                color: ColorConstants.darkgrey,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Text("Error");
          }
        },
      ),
    );
  }
}
