import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_signup/views/home_screen/buyer_home_screen.dart';

import '../utils/image_constant.dart';


class SocialMediaButtons extends StatefulWidget {
  const SocialMediaButtons({Key? key}) : super(key: key);

  @override
  State<SocialMediaButtons> createState() => _SocialMediaButtonsState();
}

class _SocialMediaButtonsState extends State<SocialMediaButtons> {
  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(permissions: ['public_profile']);

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
        final UserCredential userCredential = await _auth.signInWithCredential(credential);

        return userCredential;
      } else if (result.status == LoginStatus.cancelled) {
        print('Facebook login cancelled');
      } else {
        print('Error logging in with Facebook');
      }
    } catch (e) {
      print('Error signing in with Facebook: $e');
    }

    return null;
  }

  Future<void> addFacebookDataToFirestore(User user) async {
    try {
      final usersCollection = FirebaseFirestore.instance.collection('Users');
      final userDoc = await usersCollection.doc(user.uid).get();

      if (userDoc.exists) {
        print('Data already exists in Firestore. Skipping update.');
      } else {
        await usersCollection.doc(user.uid).set({
          'uid': user.uid,
          'displayName': user.displayName,
          'email': user.email,
          'image': user.photoURL,
          'seller': true,
          'role': 'Seller',
          'status' : "Approved"
          // Add any additional data you want to save
        });

        print('Data added to Firestore');
      }
    } catch (e) {
      print('Error adding/updating data in Firestore: $e');
    }
  }

  Future<void> handleFacebookSignIn() async {
    final UserCredential? userCredential = await signInWithFacebook();
    if (userCredential != null) {
      final user = userCredential.user;

      await addFacebookDataToFirestore(user!);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Success'),
            content: Text('Logged in with Facebook successfully.'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => home_screen(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );

      // Navigate to the home screen
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => home_screen(),
      //   ),
      // );
    }
  }



  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:  '332270028906-ob3e3pnaj7rug8n38pkm8369qsm81e28.apps.googleusercontent.com',
    serverClientId: '332270028906-0e9ftq4mkgnbtbohgucqv4jnp7o63pr9.apps.googleusercontent.com',

    scopes: <String>[
      'email',
      // 'https://www.googleapis.com/auth/contacts.readonly',
      'https://www.googleapis.com/auth/user.emails.read',
      // 'birthday',
      // 'https://www.googleapis.com/auth/user.birthday.read',
      'https://www.googleapis.com/auth/userinfo.profile',

    ],
  );

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  Future<void> addGoogleDataToFirestore(User user) async {
    try {
      final usersCollection = FirebaseFirestore.instance.collection('Users');
      final userDoc = await usersCollection.doc(user.uid).get();

      if (userDoc.exists) {
        print('Data already exists in Firestore. Skipping update.');
      } else {
        await usersCollection.doc(user.uid).set({
          'uid': user.uid,
          'displayName': user.displayName,
          'email': user.email,
          'image': user.photoURL,
          'seller': true,
          'role': 'Seller',
          'status' : "Approved"

          // Add any additional data you want to save
        });

        print('Data added to Firestore');
      }
    } catch (e) {
      print('Error adding/updating data in Firestore: $e');
    }
  }


  Future<void> handleGoogleSignIn() async {
    final UserCredential? userCredential = await signInWithGoogle();
    if (userCredential != null) {
      final user = userCredential.user;

      await addGoogleDataToFirestore(user!);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Success'),
            content: Text('Logged in with Google successfully.'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => home_screen(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }




  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 5,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.black12,
                  width: MediaQuery.of(context).size.width / 600),
              borderRadius: BorderRadius.circular(10)),
          child: IconButton(
            splashRadius: 1,
            onPressed: () {
              handleFacebookSignIn();
            },
            icon: Image.asset(ImageConstant.facebook,height: 35.h,width: 35.w),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width / 20),
        Container(
          width: MediaQuery.of(context).size.width / 5,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.black12,
                  width: MediaQuery.of(context).size.width / 600),
              borderRadius: BorderRadius.circular(10)),
          child: IconButton(
            splashRadius: 1,
            onPressed: () {
              handleGoogleSignIn();
            },
            icon: Image.asset(ImageConstant.google,height: 35.h,width: 35.w,),
          ),
        ),
        // SizedBox(width: MediaQuery.of(context).size.width / 20),
        // Container(
        //   width: MediaQuery.of(context).size.width / 5,
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       border: Border.all(
        //           color: Colors.black12,
        //           width: MediaQuery.of(context).size.width / 600)),
        //   child: IconButton(
        //     splashRadius: 1,
        //     onPressed: () {},
        //     icon: Image.asset(
        //       AppImages.apple,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
