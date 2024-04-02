//
// import 'package:flutter/material.dart';
//
//
// import '../views/cart_page/cart_view.dart';
// import '../views/favorite_page/favorite_page_view.dart';
// import '../views/main_menu/buyer_home_screen.dart';
// import '../views/user_setting/user_setting.dart';
//
// class MainPage extends StatefulWidget {
//   const MainPage({Key? key}) : super(key: key);
//
//   @override
//   _MainPageState createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   List pages =[
//     // const MenuCategories(),
//     // const AddCartView(),
//     // const IndividualDishes(),
//     // const FavoritePageView(),
//     const UserSetting()
//
//   ];
//   int currentIndex = 0;
//   void onTap(int index){
//     setState(() {
//       currentIndex = index;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: pages[currentIndex],
//         bottomNavigationBar: BottomNavigationBar(
//           unselectedFontSize: 0,
//           selectedFontSize: 0,
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Colors.white,
//           onTap: onTap,
//           currentIndex: currentIndex,
//           selectedItemColor: Colors.deepOrange,
//           unselectedItemColor: Colors.grey.withOpacity(0.5),
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           elevation: 0,
//
//           items: const [
//             BottomNavigationBarItem(label:("Menu"), icon: Icon(Icons.dashboard_rounded)),
//             BottomNavigationBarItem(label:("Cart"), icon: Icon(Icons.shopping_cart_rounded)),
//             BottomNavigationBarItem(label:("Fav"), icon: Icon(Icons.favorite)),
//             BottomNavigationBarItem(label:("Profile"), icon: Icon(Icons.person)),
//
//           ],
//
//         ),
//       ),
//     );
//   }
// }
