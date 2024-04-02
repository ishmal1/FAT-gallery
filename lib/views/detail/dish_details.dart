import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


import '../../constants/big_text.dart';
import '../../constants/order_button.dart';
import '../../constants/small_text.dart';
import '../../firebase/auth_service/auth_service.dart';
import '../../firebase/firestore_fetch_data/fetch_user_data.dart';
import '../../utils/images/images.dart';
import '../../utils/strings/app_string.dart';
import '../login/login_page.dart';

class DishDetails extends StatefulWidget {
  const DishDetails({Key? key}) : super(key: key);

  @override
  _DishDetailsState createState() => _DishDetailsState();
}

class _DishDetailsState extends State<DishDetails> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  File? image;

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>?  imageFileList = [];
  void selectImages() async{
    final List<XFile>? selectImages = await imagePicker.pickMultiImage();
    if(selectImages!.isNotEmpty){
      imageFileList!.addAll(selectImages);
    }
    setState(() {

    });
  }
  Future pickImageC() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if(image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    }on PlatformException catch(e){
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      // endDrawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       UserAccountsDrawerHeader(
      //         decoration: const BoxDecoration(
      //           gradient: LinearGradient(
      //             begin: Alignment.topRight,
      //             end: Alignment.bottomLeft,
      //             colors: [
      //               Colors.deepOrange,
      //               Colors.orange,
      //             ],
      //             transform: GradientRotation(125),
      //           ),
      //         ),
      //         accountName: Text("${name_firestore}"),
      //         accountEmail: Text(
      //           "${AuthService().currentUser?.email}",
      //           style: TextStyle(
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //         currentAccountPicture: GestureDetector(
      //           onTap: () {
      //             //Bottom Sheet
      //             showModalBottomSheet(
      //                 context: context,
      //                 builder: (context) {
      //                   return Column(
      //                     mainAxisSize: MainAxisSize.min,
      //                     children: <Widget>[
      //                       ListTile(
      //                         leading: const Icon(Icons.delete),
      //                         title: const Text(AppTexts.sheetDPhoto),
      //                         onTap: () {
      //                           Navigator.pop(context);
      //                         },
      //                       ),
      //                       ListTile(
      //                         leading: const Icon(Icons.camera_alt),
      //                         title: const Text(AppTexts.sheetTPhoto),
      //                         onTap: () {
      //                           pickImageC();
      //                         },
      //                       ),
      //                       ListTile(
      //                         leading: const Icon(Icons.photo),
      //                         title: const Text(AppTexts.sheetCPhoto),
      //                         onTap: () {
      //                           selectImages();
      //                         },
      //                       ),
      //                     ],
      //                   );
      //                 });
      //           },
      //           child: CircleAvatar(
      //             backgroundImage: AssetImage(AppImages.faizan),
      //           ),
      //         ),
      //       ),
      //       ListTile(
      //         leading: const Icon(
      //           Icons.settings,
      //         ),
      //         title: const Text(AppTexts.drawerS),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(
      //           Icons.bookmark,
      //         ),
      //         title: const Text(AppTexts.drawerF),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(
      //           Icons.notifications_rounded,
      //         ),
      //         title: const Text(AppTexts.drawerN),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(
      //           Icons.privacy_tip,
      //         ),
      //         title: const Text(AppTexts.drawerPP),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(
      //           Icons.logout,
      //         ),
      //         title: const Text(AppTexts.drawerL),
      //         onTap: () {
      //           FirebaseAuth.instance.signOut();
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => const LoginPage()));
      //           ScaffoldMessenger.of(context).showSnackBar(
      //               const SnackBar(content: Text(AppTexts.drawerLogout)));
      //         },
      //       ),
      //       const AboutListTile(
      //         icon: Icon(
      //           Icons.info,
      //         ),
      //         child: Text(AppTexts.drawerA),
      //         applicationIcon: Icon(
      //           Icons.shopping_cart,
      //         ),
      //         applicationName: AppTexts.drawerAppName,
      //         applicationVersion: AppTexts.drawerAppVersion,
      //         applicationLegalese: AppTexts.drawerAppLegalese,
      //       ),
      //     ],
      //   ),
      // ),
      body: Column(
        children: [
          Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35))),
            elevation: 3,
            color: Colors.grey.shade300,
            child: SizedBox(
              // width: MediaQuery.of(context).size.width * 100,
              // height: MediaQuery.of(context).size.height / 2.4,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SafeArea(
                          child: InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 41.1,),
                                child: const Icon(Icons.arrow_back_rounded)),
                          ),
                        ),
                        SafeArea(
                          child: InkWell(
                            onTap: (){
                              _key.currentState!.openEndDrawer();
                            },
                            child: Container(
                                margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 35,),
                                child: const Icon(Icons.menu)),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Card(
                      elevation: 3,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            size: MediaQuery.of(context).size.width / 13.7,
                            color: Colors.black54,
                          ),
                          hintText: AppTexts.searchBar,
                          hintStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 22.8,
                            color: Colors.black54,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 34.2,right: MediaQuery.of(context).size.width / 34.2,top: MediaQuery.of(context).size.height / 60,bottom: MediaQuery.of(context).size.height / 60,),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 51.4, top: MediaQuery.of(context).size.height / 82,),
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.height / 8.4,
                      foregroundColor: Colors.transparent,
                      foregroundImage: AssetImage(AppImages.plateImg),
                      backgroundColor: Colors.transparent,
                    ),
                  ), //Text//SizedBox
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 164.1,),
            child: Container(
              width: MediaQuery.of(context).size.width / 4.3,
              height: MediaQuery.of(context).size.height / 102.5,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.deepOrange,
                      Colors.orange,
                    ]),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          BigText(text: AppTexts.textFF,size: MediaQuery.of(context).size.width / 11.75,fontWeight: FontWeight.w800,),
          SizedBox(
            height: MediaQuery.of(context).size.height / 164.1,
          ),
          Text(AppTexts.textOffer,style: TextStyle(
            color: Colors.black38,
            fontSize: MediaQuery.of(context).size.width / 25,
          ),),
          SizedBox(
            height: MediaQuery.of(context).size.height / 41,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 20.51,
              width: MediaQuery.of(context).size.width / 3.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.deepOrange,width: MediaQuery.of(context).size.width / 170,),
              ),
            child: Center(
              child: Text(
                "\$5.00",
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: MediaQuery.of(context).size.width / 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Roboto"),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 82,
          ),
          Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 20,right: MediaQuery.of(context).size.width / 20,),
            child: SmallText(
              text: AppTexts.textLong,size: MediaQuery.of(context).size.width / 27,
              height: MediaQuery.of(context).size.height / 520,
              color: Colors.black38,
              // fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 26,
          ),
          OrderButton(onPressed: (){
            // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AddCartView()));
          })
        ],
      ),
    );
  }
}
