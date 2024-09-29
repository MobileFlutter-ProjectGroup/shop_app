import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String image;
  final String title;
  final String description;
  final double price;
  final int quantity;
  // final double weight;
  final String id;
  final Color color;
  final String? creatorId;
  bool isFavorite;
  // String dummyText =
  //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.quantity,
    // required this.weight,
    required this.color,
    this.creatorId,
    this.isFavorite = false,
  });
  void _setFavorite(bool favorite) {
    isFavorite = favorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(String authToken, String userId) async {
    final oldFavorite = isFavorite;
    final url =
        'https://fluttershopapp-b71a9-default-rtdb.asia-southeast1.firebasedatabase.app/userFavorite/$userId/$id.json?auth=$authToken!';
    _setFavorite(!isFavorite);
    final response = await http.put(
      Uri.parse(url),
      body: json.encode(
        isFavorite,
      ),
    );
    if (response.statusCode >= 400) {
      isFavorite = oldFavorite;
      _setFavorite(oldFavorite);
      throw HttpException(
          'http request failed with status code ${response.statusCode}');
    }
  }

  static List<Product> products = [];
}
