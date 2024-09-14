import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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

  Future<void> fetchAndAddProduct() async {
    const url =
        'https://fluttershopapp-b71a9-default-rtdb.asia-southeast1.firebasedatabase.app/products.json';
    final response = await http.get(
      Uri.parse(url),
    );
    final loadedData = json.decode(response.body) as Map<String, dynamic>;
    List<Product> productData = [];
    loadedData.forEach(
      (prodId, prod) {
        productData.add(
          Product(
            id: prodId,
            image: prod['imageURL'],
            title: prod['title'],
            price: prod['price'],
            description: prod['description'],
            quantity: 1,
            color: Colors.transparent,
          ),
        );
      },
    );
    _items = productData;
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    const url =
        'https://fluttershopapp-b71a9-default-rtdb.asia-southeast1.firebasedatabase.app/products.json';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageURL': product.image,
            'isFavorite': product.isFavorite,
          },
        ),
      );

      final data = json.decode(response.body);
      Product newProduct = Product(
        id: data['name'],
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
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final url =
        'https://fluttershopapp-b71a9-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json';

    await http.patch(Uri.parse(url),
        body: json.encode({
          'title': newProduct.title,
          'imageURL': newProduct.image,
          'price': newProduct.price,
          'description': newProduct.description,
        }));
    int index = _items.indexWhere((p) => p.id == id);
    if (index >= 0) {
      _items[index] = newProduct;
    }
    notifyListeners();
  }

  Future<void> deleteProduct(String id) {
    final exitProduct = findProductById(id);
    int exitIndex = _items.indexWhere((p) => p.id == id);
    final url =
        'https://fluttershopapp-b71a9-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json';
    return http.delete(Uri.parse(url)).then((_) {
      _items.removeWhere((p) => p.id == id);
      notifyListeners();
    }).catchError((error) {
      _items.insert(exitIndex, exitProduct);
      notifyListeners();
    });
  }
}
