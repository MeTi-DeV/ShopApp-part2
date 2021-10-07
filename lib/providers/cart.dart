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

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void CartClear() {
    _items = {};
    notifyListeners();
  }
//comment 1 : create a new function for SnackBarAction()
  void removeRecentItem(String productId) {
    //comment 2 : here determined if there is not any item in cartitem list with this id do nothing
    if (!_items.containsKey(productId)) {
      return;
    }
    // comment 3 : here determined if there is a item in cart list with this id decrease just one count of that in cartitem list
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (existingItem) => CartItem(
              id: existingItem.id,
              title: existingItem.title,
              price: existingItem.price,
              quantity: existingItem.quantity - 1));
    } else {
      //comment 4 : here determined if there is just a count of this product by this id delete that from my cart
      _items.remove(productId);
    }
    notifyListeners();
  }
}
