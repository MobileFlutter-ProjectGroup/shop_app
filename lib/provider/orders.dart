import 'package:flutter/material.dart';

import 'cart.dart';

class OrderItem {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.total,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  final List<OrderItem> _Itmes = [];

  List<OrderItem> get items {
    return [..._Itmes];
  }

  void addOrder(List<CartItem> products, double total) {
    _Itmes.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        total: total,
        products: products,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
