import 'package:flutter/material.dart';

import 'product.dart';

class Products with ChangeNotifier {
  // bool _shwoFavorite = false;
  final List<Product> _items = Product.products;

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

  void addProduct(Product product) {
    Product newProduct = Product(
      id: DateTime.now().toString(),
      image: product.image,
      title: product.title,
      price: product.price,
      description: product.description,
      quantity: product.quantity,
      color: product.color,
    );
    _items.add(newProduct);
    // _items.insert(0, newProduct);
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    int index = _items.indexWhere((p) => p.id == id);
    if (index >= 0) {
      _items[index] = newProduct;
    }
    notifyListeners();
  }

  void deleteProduct(String id) {
    _items.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
