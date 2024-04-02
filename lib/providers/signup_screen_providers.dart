import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class SingUpPageProviders with ChangeNotifier {
  bool? nameisElegible,
      emailisElegible,
      passwordisElegible,
      cofirmpasswordisElegible;
  String namemessage = "";
  String emailmessage = "";
  String passwordmessage = "";
  String confirmpasswordmessage = "";
  String? passwordvalue;

  void nameValidation(String name) {
    if (name.isAlphabetOnly) {
      nameisElegible = true;
      namemessage = "";
      notifyListeners();
    } else {
      nameisElegible = false;
      namemessage = "Invalid Name";
      notifyListeners();
    }
  }

  void emailValidation(String email) {
    if (EmailValidator.validate(email)) {
      emailisElegible = true;
      emailmessage = "";
      notifyListeners();
    } else {
      emailisElegible = false;
      emailmessage = "Invalid Email Address";
      notifyListeners();
    }
  }

  void passswordValidation(String password) {
    passwordvalue = password;
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
    if (regex.hasMatch(password)) {
      passwordisElegible = true;
      passwordmessage = '';
      notifyListeners();
    } else {
      passwordisElegible = false;
      passwordmessage = 'Weak Password';
      notifyListeners();
    }
  }

  void confirmpasswordValidation(String confirmpassword) {
    if (confirmpassword == passwordvalue) {
      cofirmpasswordisElegible = true;
      confirmpasswordmessage = "";
      notifyListeners();
    } else {
      cofirmpasswordisElegible = false;
      confirmpasswordmessage = "Password Don't Matched";
      notifyListeners();
    }
  }
}
