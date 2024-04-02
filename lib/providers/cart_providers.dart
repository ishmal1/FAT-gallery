import 'package:flutter/cupertino.dart';

class CartController extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> performPayment() async {
    _isLoading = true;
    notifyListeners();

    // Simulate a delay for demonstration purposes (replace with your actual payment process)
    await Future.delayed(Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
  }
}
