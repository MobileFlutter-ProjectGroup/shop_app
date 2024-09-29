import 'dart:io';

import 'package:flutter/material.dart';
import 'cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final String slipNumber;
  final double total;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.slipNumber,
    required this.total,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  String? authToken;
  Orders();
  Orders.update(this.authToken, this._itmes);

  List<OrderItem> _itmes = [];
  List<OrderItem> get items {
    return [..._itmes];
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://fluttershopapp-b71a9-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json?auth=$authToken!';
    final response = await http.get(Uri.parse(url));
    List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body);
    if (extractedData == null) {
      return;
    }
    (extractedData as Map<String, dynamic>).forEach(
      (orderId, orderData) {
        loadedOrders.add(
          OrderItem(
            id: orderId,
            slipNumber: orderData['slip'],
            total: orderData['total'],
            products: (orderData['product'] as List<dynamic>)
                .map(
                  (product) => CartItem(
                    id: product['id'],
                    title: product['title'],
                    price: product['price'],
                    quantity: product['quantity'],
                    image: product['imageURL'],
                  ),
                )
                .toList(),
            dateTime: DateTime.parse(orderData['date']),
          ),
        );
      },
    );
    _itmes = loadedOrders;
    notifyListeners();
  }

  Future<void> addOrder(
      List<CartItem> products, double total, String slipNumber) async {
    final url =
        'https://fluttershopapp-b71a9-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json?auth=$authToken!';
    final response = await http.post(
      Uri.parse(url),
      body: json.encode(
        {
          'total': total,
          'slip': slipNumber,
          'date': DateTime.now().toIso8601String(),
          'product': products
              .map(
                (p) => {
                  'id': p.id,
                  'title': p.title,
                  'price': p.price,
                  'imageURL': p.image,
                  'quantity': p.quantity
                },
              )
              .toList(),
        },
      ),
    );
    if (response.statusCode >= 400) {
      throw HttpException(
          'Http request failed with status code ${response.statusCode}');
    }
    final orderData = json.decode(response.body);
    _itmes.insert(
      0,
      OrderItem(
        id: orderData['name'],
        slipNumber: slipNumber,
        total: total,
        products: products,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
