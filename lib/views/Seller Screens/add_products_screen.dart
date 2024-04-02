import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../controller/product_controller.dart';
import '../../utils/color_constant.dart';
import '../../widgets/custom_button.dart';

class Add_products extends StatefulWidget {
  const Add_products({Key? key}) : super(key: key);
  @override
  State<Add_products> createState() => _Add_productsState();
}

class _Add_productsState extends State<Add_products> {
  final TextEditingController title = TextEditingController();
  final ProductController productController = ProductController();

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
            "Add Product",
            style: TextStyle(
              color: ColorConstants.black,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            width: Get.width * 100,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: ColorConstants.green,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    width: 90,
                    height: 90,
                    child: productController.image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            child: Image.file(
                              productController.image!.absolute,
                              fit: BoxFit.cover,
                            ))
                        : const Icon(Icons.image),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                custom_button(
                    label: "Select Images",
                    backgroundcolor: ColorConstants.purple,
                    textcolor: ColorConstants.white,
                    function: () {
                      productController.uploadImage();
                    }),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      fields(controller: title, text: "Product Name"),
                      fields(controller: title, text: "Price"),
                      fields(
                        controller: title,
                        text: "Product Description",
                        maxlines: 5,
                      ),
                    ],
                  ),
                ),
                custom_button(
                    label: "Publish Product",
                    backgroundcolor: ColorConstants.purple,
                    textcolor: ColorConstants.white,
                    function: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Center(child: Text('Confirmation')),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Are you sure to publish your product",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ColorConstants.green,
                                      ),
                                    ),
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        ElevatedButton(
                                            child: const Text('Yes'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            }),
                                        ElevatedButton(
                                            child: const Text('No'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            })
                                      ])
                                ],
                              ),
                            );
                          });
                    }),
              ],
            ),
          ),
        ));
  }
}

class fields extends StatelessWidget {
  fields(
      {Key? key, required this.controller, required this.text, this.maxlines})
      : super(key: key);

  TextEditingController controller;
  int? maxlines;
  String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          maxLines: maxlines,
          decoration: InputDecoration(
            label: Text(text),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
