import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

class LoginPageProviders with ChangeNotifier {
  bool? emailElegible;
  bool? passwordElegible;
  String? emailmessage = "";
  String? passwordmessage = "";

  void emailValidation(String email) {
    if (EmailValidator.validate(email)) {
      emailElegible = true;
      emailmessage = "";
      notifyListeners();
    } else {
      emailElegible = false;
      emailmessage = "Invalid Email Address";
      notifyListeners();
    }
  }

  void passswordValidation(String value) {
    if (value.length < 8) {
      passwordElegible = false;
      passwordmessage = 'Weak Password';
      notifyListeners();
    } else {
      passwordElegible = true;
      passwordmessage = '';
      notifyListeners();
    }
  }
}
