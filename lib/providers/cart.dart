import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;
  CartItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1));
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: 1),
      );
    }
    print(_items.keys);
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach(
      (key, CartItem) {
        total += CartItem.price * CartItem.quantity;
      },
    );
    return total;
  }

  //comment 1 : here create removeItem handler for remove each item in cart
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
//comment 2 : add CartClear for clear cart list when add all  cart items to order screen
  void CartClear() {
    _items = {};
    notifyListeners();
  }
}
