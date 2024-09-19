import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;
  final String image;
  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.image,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items => {..._items};

  int itemCount() {
    return items.length;
  }

  double get totalAmount {
    double total = 0.0;

    items.forEach(
      (key, cartItem) {
        total += (cartItem.price * cartItem.quantity);
      },
    );
    return total;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  void removeSingleCartItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existedCartItem) => CartItem(
          id: existedCartItem.id,
          title: existedCartItem.title,
          price: existedCartItem.price,
          quantity: existedCartItem.quantity - 1,
          image: existedCartItem.image,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void addItem(String productId, String title, double price, String image) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (extenedCartItem) => CartItem(
          id: extenedCartItem.id,
          title: extenedCartItem.title,
          price: extenedCartItem.price,
          quantity: extenedCartItem.quantity + 1,
          image: image,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          title: title,
          price: price,
          quantity: 1,
          image: image,
        ),
      );
    }
    notifyListeners();
  }
}
