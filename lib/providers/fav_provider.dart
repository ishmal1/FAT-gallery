import 'package:flutter/foundation.dart';

class FavoriteProvider with ChangeNotifier {
  List<String> _favoriteDishes = [];

  List<String> get favoriteDishes => _favoriteDishes;

  void addFavorite(String dishId) {
    if (!_favoriteDishes.contains(dishId)) {
      _favoriteDishes.add(dishId);
      notifyListeners();
    }
  }

  void removeFavorite(String dishId) {
    _favoriteDishes.remove(dishId);
    notifyListeners();
  }

  bool isFavorite(String dishId) {
    return _favoriteDishes.contains(dishId);
  }
  String userId = ''; // Add userId property

  // Rest of your existing code

  void setUserId(String id) {
    userId = id;
    notifyListeners();
  }
}
