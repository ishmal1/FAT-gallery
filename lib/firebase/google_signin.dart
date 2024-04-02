import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleLoginPage extends StatefulWidget {
  @override
  _GoogleLoginPageState createState() => _GoogleLoginPageState();
}

class _GoogleLoginPageState extends State<GoogleLoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:  '332270028906-ob3e3pnaj7rug8n38pkm8369qsm81e28.apps.googleusercontent.com',
    serverClientId: '332270028906-0e9ftq4mkgnbtbohgucqv4jnp7o63pr9.apps.googleusercontent.com',

    scopes: <String>[
      'email',
      // 'https://www.googleapis.com/auth/contacts.readonly',
      // 'https://www.googleapis.com/auth/user.emails.read',
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

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  Future<void> addDataToFirestore(User user) async {
    try {
      final usersCollection = FirebaseFirestore.instance.collection('Users');

      await usersCollection.doc(user.uid).set({
        'uid': user.uid,
        'displayName': user.displayName,
        'email': user.email,
        'image' : user.photoURL,
        'seller' : true,
        "role" : "Seller"
        // Add any additional data you want to save
      });

      print('Data added to Firestore');
    } catch (e) {
      print('Error adding data to Firestore: $e');
    }
  }

  Future<void> handleSignIn() async {
    final UserCredential? userCredential = await signInWithGoogle();
    if (userCredential != null) {
      final user = userCredential.user;

      await addDataToFirestore(user!);

      // Show success dialog and navigate to the next screen
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
                  // Navigate to the next screen
                  // ...
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Sign in with Google'),
          onPressed: handleSignIn,
        ),
      ),
    );
  }
}


//
// class SignInWithGoogleScreen extends StatefulWidget {
//   @override
//   _SignInWithGoogleScreenState createState() => _SignInWithGoogleScreenState();
// }
//
// class _SignInWithGoogleScreenState extends State<SignInWithGoogleScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   bool _isLoading = false;
//
//   Future<UserCredential?> _signInWithGoogle() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       // Sign in with Google
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       final GoogleSignInAuthentication googleAuth =
//       await googleUser!.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//       final UserCredential userCredential =
//       await _auth.signInWithCredential(credential);
//
//       // Store user credentials in Firestore
//       await storeUserInFirestore(userCredential);
//
//       return userCredential;
//     } catch (e) {
//       print('Error signing in with Google: $e');
//       return null;
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   Future<void> storeUserInFirestore(UserCredential userCredential) async {
//     final uid = userCredential.user!.uid;
//     final email = userCredential.user!.email;
//
//     final firestore = FirebaseFirestore.instance;
//     final collection = firestore.collection('users');
//     final document = collection.doc(uid);
//
//     await document.set({
//       'uid': uid,
//       'email': email,
//     });
//   }


