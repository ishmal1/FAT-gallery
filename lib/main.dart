import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:login_signup/firebase/auth_service/auth_service.dart';
import 'package:login_signup/providers/card_provider.dart';
import 'package:login_signup/providers/cart_providers.dart';
import 'package:login_signup/providers/fav_provider.dart';
import 'package:login_signup/providers/login_screen_providers.dart';
import 'package:login_signup/providers/signup_screen_providers.dart';
import 'package:login_signup/providers/slider_provider.dart';
import 'package:login_signup/utils/color_constant.dart';
import 'package:login_signup/views/home_screen/buyer_home_screen.dart';
import 'package:login_signup/views/login/login_page.dart';
import 'package:login_signup/views/no_internet_connection_screen.dart';
import 'package:login_signup/views/splashscreen/splashscreen_page.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(


  options: FirebaseOptions(
      apiKey: "AIzaSyCZyhPE_GgNNwrC_J-xb-3EQf_LC_ndADE",
      authDomain: "fat-gallery-27490.firebaseapp.com",
      projectId: "fat-gallery-27490",
      storageBucket: "fat-gallery-27490.appspot.com",
      messagingSenderId: "241272891472",
      appId: "1:241272891472:web:f83d26b725910937c7c955",
      measurementId: "G-W815WZZNN0"
  )
  );
  FlutterError.onError = (FlutterErrorDetails details) {
    print('main.onError: details: ${details.toString()}');
  };

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.put(AuthService());

  runApp(const MyApp());
}

 final auth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: ScreenUtilInit(
        builder: (BuildContext context, Widget? child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<LoginPageProviders>(
                  create: (context) => LoginPageProviders()),
              ChangeNotifierProvider<SingUpPageProviders>(
                  create: (context) => SingUpPageProviders()),
              ChangeNotifierProvider<FavoriteProvider>(
                  create: (context) => FavoriteProvider()),
              ChangeNotifierProvider<SliderProvider>(
                  create: (context) => SliderProvider()),
          ChangeNotifierProvider<CartController>(
          create: (context) => CartController(),),
          ChangeNotifierProvider<CreditCardFlipModel>(
          create: (context) => CreditCardFlipModel(),),

            ],
            child: GetMaterialApp(
                title: 'Ecommerce Store',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    fontFamily: 'Raleway',
                    primarySwatch: ColorConstants.themecolor,
                    iconTheme: IconThemeData(
                      color: ColorConstants.black,
                    )),
                routes: {
                  '/login': (context) => LoginPage(),
                },
                onGenerateRoute: _generateRoute,
               initialRoute: '/',
             home: splash_screen()),
               // home:  adminlogin_screen()),
          );
        },
      ),
    );
  }
  Route<dynamic>? _generateRoute(RouteSettings settings) {
    // Define your routes and return the appropriate Widget for each route
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => splash_screen());
      case '/home':
        return MaterialPageRoute(builder: (_) => home_screen());
      case '/noInternet':
        return MaterialPageRoute(builder: (_) => no_internet_screen());
    // Add more routes as needed
      default:
        return null;
    }
  }

}

