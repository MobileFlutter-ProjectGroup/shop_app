import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/custom_http_exception.dart';
import 'product.dart';

class Products with ChangeNotifier {
  // bool _shwoFavorite = false;
  List<Product> _items = Product.products;

  List<Product> get favorites =>
      _items.where((product) => product.isFavorite).toList();
  List<Product> get items => [..._items];

  // List<Product> get userProducts =>
  //     _items.where((product) => product.creatorId == userId).toList();

  // void setShowFavorite() {
  //   _shwoFavorite = true;
  //   notifyListeners();
  // }

  // void setShowAll() {
  //   _shwoFavorite = false;
  //   notifyListeners();
  // }
  String? authToken;
  String? userId;
  Products();
  Products.update(this.authToken, this.userId, this._items);

  Product findProductById(String id) {
    return items.firstWhere(
      (p) => p.id.toString() == id,
    );
  }

  Future<void> fetchAndAddProduct([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    final url =
        'https://fluttershopapp-b71a9-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$authToken!&$filterString';
    final response = await http.get(
      Uri.parse(url),
    );
    final loadedData = json.decode(response.body) as Map<String, dynamic>;
    List<Product> productData = [];
    final fUrl =
        'https://fluttershopapp-b71a9-default-rtdb.asia-southeast1.firebasedatabase.app/userFavorite/$userId.json?auth=$authToken!';
    final fResponse = await http.get(Uri.parse(fUrl));
    final loadedFavorite = json.decode(fResponse.body);

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
            creatorId: prod['creatorId'],
            isFavorite: loadedFavorite == null
                ? false
                : loadedFavorite[prodId] ?? false,
          ),
        );
      },
    );
    _items = productData;
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://fluttershopapp-b71a9-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$authToken!';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageURL': product.image,
            'creatorId': userId
            //'isFavorite': product.isFavorite,
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
        creatorId: data['creatorId'],
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
        'https://fluttershopapp-b71a9-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$authToken!';

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

  Future<void> deleteProduct(String id) async {
    final exitProduct = findProductById(id);
    int exitIndex = _items.indexWhere((p) => p.id == id);
    final url =
        'https://fluttershopapp-b71a9-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$authToken!';
    final response = await http.delete(Uri.parse(url));
    _items.removeWhere((p) => p.id == id);
    notifyListeners();
    if (response.statusCode >= 400) {
      _items.insert(exitIndex, exitProduct);
      notifyListeners();
      throw CustomHttpException(
          'Http request failed with status code ${response.statusCode}');
    }
  }
}
