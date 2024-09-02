import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String image;
  final String title;
  final String description;
  final double price;
  final int size;
  // final double weight;
  final int id;
  final Color color;
  bool isFavorite;
  // String dummyText =
  //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.size,
    // required this.weight,
    required this.color,
    this.isFavorite = false,
  });
  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  static List<Product> products = [
    Product(
        id: 1,
        title: "Laptop",
        price: 2000,
        size: 12,
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
        image: "assets/images/laptop.jfif",
        color: const Color(0xFF3D82AE)),
    Product(
        id: 2,
        title: "Power Bank",
        price: 120,
        size: 8,
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
        image: "assets/images/powerbank.jfif",
        color: const Color(0xFFD3A984)),
    Product(
        id: 3,
        title: "TV",
        price: 1000,
        size: 10,
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
        image: "assets/images/tv.jfif",
        color: const Color(0xFF989493)),
    Product(
        id: 4,
        title: "Couch",
        price: 1200,
        size: 11,
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
        image: "assets/images/couch.jfif",
        color: const Color(0xFFE6B398)),
    Product(
        id: 5,
        title: "Coat",
        price: 250,
        size: 12,
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
        image: "assets/images/officecoat.jfif",
        color: const Color(0xFFFB7883)),
    Product(
      id: 6,
      title: "Office Code",
      price: 234,
      size: 12,
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
      image: "assets/images/bag_6.png",
      color: const Color(0xFFAEAEAE),
    ),
    Product(
      id: 7,
      title: "Readme Note12",
      price: 60,
      size: 12,
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
      image: "assets/images/readme.jfif",
      color: const Color(0xFFAEAEAE),
    ),
    Product(
      id: 8,
      title: "Watch",
      price: 500,
      size: 12,
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
      image: "assets/images/watch.jfif",
      color: const Color(0xFFAEAEAE),
    ),
    Product(
      id: 9,
      title: "Lotion",
      price: 60,
      size: 12,
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
      image: "assets/images/lotion.jfif",
      color: const Color(0xFFAEAEAE),
    ),
    Product(
      id: 10,
      title: "Dress",
      price: 400,
      size: 12,
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
      image: "assets/images/dress.jfif",
      color: const Color(0xFFAEAEAE),
    ),
    Product(
      id: 11,
      title: "Sprit",
      price: 10,
      size: 12,
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
      image: "assets/images/sprit.jfif",
      color: const Color(0xFFAEAEAE),
    ),
    Product(
      id: 12,
      title: "Ball",
      price: 7,
      size: 12,
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.",
      image: "assets/images/ball.jfif",
      color: const Color(0xFFAEAEAE),
    ),
  ];
}
