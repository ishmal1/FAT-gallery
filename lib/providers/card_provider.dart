import 'package:flutter/cupertino.dart';

class CreditCardFlipModel extends ChangeNotifier {
  bool _isFlipped = false;

  bool get isFlipped => _isFlipped;

  void toggleFlippedState() {
    _isFlipped = !_isFlipped;
    notifyListeners();
  }

  void switchCard() {
    toggleFlippedState();
  }
}