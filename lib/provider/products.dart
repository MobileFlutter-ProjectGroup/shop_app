import 'package:flutter/material.dart';

import 'product.dart';

class Products with ChangeNotifier {
  // bool _shwoFavorite = false;
  List<Product> _items = Product.products;

  List<Product> get favorites =>
      _items.where((product) => product.isFavorite).toList();
  List<Product> get items {
    return [..._items];
    // if (_shwoFavorite) {
    //   return _items
    //       .where(
    //         (product) => product.isFavorite,
    //       )
    //       .toList();
    // } else {
    //   return [..._items];
    // }
  }

  // void setShowFavorite() {
  //   _shwoFavorite = true;
  //   notifyListeners();
  // }

  // void setShowAll() {
  //   _shwoFavorite = false;
  //   notifyListeners();
  // }

  Product findProductById(String id) {
    return items.firstWhere(
      (p) => p.id.toString() == id,
    );
  }
}
