import 'package:flutter/foundation.dart';

class CartState extends ChangeNotifier {
  int _cartCount = 0;

  void setCartCount(int count) {
    _cartCount = count;
    notifyListeners();
  }

  int get getCartCount => _cartCount;

}