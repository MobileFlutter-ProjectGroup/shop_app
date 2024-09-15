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
  final List<OrderItem> _itmes = [];

  List<OrderItem> get items {
    return [..._itmes];
  }

  Future<void> addOrder(
      List<CartItem> products, double total, String slipNumber) async {
    const url =
        'https://fluttershopapp-b71a9-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json';
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
