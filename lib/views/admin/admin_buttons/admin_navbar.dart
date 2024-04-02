import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/firebase/auth_service/auth_service.dart';
import 'package:login_signup/views/admin/admin_buttons/request_restaurants.dart';
import 'package:login_signup/views/admin/login_page/admin_login.dart';

import '../../../constants/custom_admin_navbar.dart';
import '../../../firebase/firestore_fetch_data/fetch_user_data.dart';
import '../../../utils/images/images.dart';
import '../../../utils/strings/app_string.dart';
import '../../login/login_page.dart';
import '../../products_pages/restaurant_admin.dart';
import 'approve_reject_buttons.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final GlobalKey<ScaffoldState> _keyD = GlobalKey();
  int _currentIndex = 0;
  List<Object> approveList = [];
  List<Object> requestList = [];

  final _inactiveColor = Colors.black54;
  CollectionReference restaurants = FirebaseFirestore.instance.collection("Restaurants");
  final Stream<QuerySnapshot> snapshot = FirebaseFirestore.instance
      .collection("Restaurants")
      .snapshots(includeMetadataChanges: true);

  Future getRestaurantsList() async {
    approveList.clear();
    var collection = await FirebaseFirestore.instance
        .collection('Restaurants')
        .where('status', isEqualTo: "Approved");
    await collection.get().then((value) => value.docs.forEach((element) {
          print(element.reference);
          approveList.add(element.reference.id);
        }));
  }

  Future getRequestList() async {
    requestList.clear();
    var collection = await FirebaseFirestore.instance
        .collection('Restaurants')
        .where('status', isEqualTo: "Pending");
    await collection.get().then((value) => value.docs.forEach((element) {
          // print(element.reference);
          requestList.add(element.reference.id);
          print(requestList.length);
        }));
  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      containerHeight: MediaQuery.of(context).size.height / 11.5,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: false,
      itemCornerRadius: 10,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() {
        _currentIndex = index;
      }),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.assignment_turned_in_rounded),
          title: Text(
            'Approved',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 35,
            ),
          ),
          activeColor: Colors.deepOrange,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.assignment_returned_rounded),
          title: Text(
            'Requests',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 35,
            ),
          ),
          activeColor: Colors.deepOrange,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      Scaffold(
        key: _keyD,
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.deepOrange,
                      Colors.orange,
                    ],
                    transform: GradientRotation(125),
                  ),
                ),
                accountName: Text("${"Tayyab Waseem"}"),
                accountEmail: Text(
                  "${'tayyabwaseem05@gmail.com'}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                currentAccountPicture: GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    backgroundImage: AssetImage(AppImages.faizan),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.swap_horiz,
                ),
                title: Text(AppTexts.drawerSwitchR),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text(AppTexts.switchRestaurant)));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RestaurantAdmin()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.notifications_rounded,
                ),
                title: const Text(AppTexts.drawerN),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.privacy_tip,
                ),
                title: const Text(AppTexts.drawerPP),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                ),
                title: const Text(AppTexts.drawerL),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text(AppTexts.drawerLogout)));
                },
              ),
              const AboutListTile(
                icon: Icon(
                  Icons.info,
                ),
                child: Text(AppTexts.drawerA),
                applicationIcon: Icon(
                  Icons.shopping_cart,
                ),
                applicationName: AppTexts.drawerAppName,
                applicationVersion: AppTexts.drawerAppVersion,
                applicationLegalese: AppTexts.drawerAppLegalese,
              ),
            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width / 25),
              child: GestureDetector(
                  onTap: () {
                    _keyD.currentState!.openEndDrawer();
                    setState(() {
                      // fetchData();
                    });
                  },
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                  )),
            )
          ],
          bottomOpacity: 0.0,
          elevation: 0.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(
            "Approved Restaurants",
            style: TextStyle(color: Colors.deepOrange),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(),
              Expanded(
                child: StreamBuilder(
                  stream: restaurants.where('status', isEqualTo: 'Approved').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
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
                    return ListView(
                      children: snapshot.data!.docs.map((restaurants) {
                        return RestaurantCard(restaurants: restaurants,);
                      }).toList(),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      Scaffold(
        key: _key,
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.deepOrange,
                      Colors.orange,
                    ],
                    transform: GradientRotation(125),
                  ),
                ),
                accountName: Text("${'Tayyab waseem'}"),
                accountEmail: Text(
                  "${AuthService().currentUser?.email}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                currentAccountPicture: GestureDetector(
                  onTap: () {

                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage(AppImages.faizan),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.swap_horiz,
                ),
                title: Text(AppTexts.drawerSwitchR),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text(AppTexts.switchRestaurant)));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RestaurantAdmin()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.bookmark,
                ),
                title: const Text(AppTexts.drawerF),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.notifications_rounded,
                ),
                title: const Text(AppTexts.drawerN),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.privacy_tip,
                ),
                title: const Text(AppTexts.drawerPP),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                ),
                title: const Text(AppTexts.drawerL),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text(AppTexts.drawerLogout)));
                },
              ),
              const AboutListTile(
                icon: Icon(
                  Icons.info,
                ),
                child: Text(AppTexts.drawerA),
                applicationIcon: Icon(
                  Icons.shopping_cart,
                ),
                applicationName: AppTexts.drawerAppName,
                applicationVersion: AppTexts.drawerAppVersion,
                applicationLegalese: AppTexts.drawerAppLegalese,
              ),
            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width / 25),
              child: GestureDetector(
                  onTap: () {
                    _key.currentState!.openEndDrawer();
                    setState(() {
                      // fetchData();
                    });
                  },
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                  )),
            )
          ],
          bottomOpacity: 0.0,
          elevation: 0.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(
            "Pending Approvals",
            style: TextStyle(color: Colors.deepOrange),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(),
              Expanded(
                child: StreamBuilder(
                  stream: restaurants.where('status', isEqualTo: 'Pending').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
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
                    return ListView(
                      children: snapshot.data!.docs.map((restaurants) {
                        return RestaurantCard(restaurants: restaurants,);
                      }).toList(),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}
