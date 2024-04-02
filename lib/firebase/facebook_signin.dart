import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookLoginPage extends StatefulWidget {
  @override
  _FacebookLoginPageState createState() => _FacebookLoginPageState();
}

class _FacebookLoginPageState extends State<FacebookLoginPage> {
  Future<UserCredential?> signInWithFacebook() async {
    try {
      // Log in with Facebook
      // final LoginResult result = await FacebookAuth.instance.login();
      final LoginResult result = await FacebookAuth.instance.login(permissions: ['public_profile']);


      // Check if the login was successful
      if (result.status == LoginStatus.success) {
        // Get the access token
        final AccessToken accessToken = result.accessToken!;

        // Create the Firebase credential
        final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);

        // Sign in with the credential
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        // Add user data to Firestore
        await addDataToFirestore(userCredential.user!);

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

  Future<void> addDataToFirestore(User user) async {
    try {
      final usersCollection = FirebaseFirestore.instance.collection('Users');

      await usersCollection.doc(user.uid).set({
        'uid': user.uid,
        'displayName': user.displayName,
        'email': user.email,
        "image" : user.photoURL,
        // Add any additional data you want to save
      });

      print('Data added to Firestore');
    } catch (e) {
      print('Error adding data to Firestore: $e');
    }
  }

  Future<void> handleSignIn() async {
    final UserCredential? userCredential = await signInWithFacebook();
    if (userCredential != null) {
      final user = userCredential.user;

      // Show success dialog and navigate to the next screen
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
          child: Text('Sign in with Facebook'),
          onPressed: handleSignIn,
        ),
      ),
    );
  }
}
