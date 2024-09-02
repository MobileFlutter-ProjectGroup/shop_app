import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';
import '../provider/products.dart';

class ProductDetail extends StatelessWidget {
  // final String id;
  // final String title;

  const ProductDetail({
    super.key,
    // required this.id,
    // required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context)?.settings.arguments as String;
    // final Product product = Provider.of<Products>(context)
    //     .items
    //     .firstWhere((p) => p.id.toString() == productId);
    Product product = Provider.of<Products>(context, listen: false)
        .findProductById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Center(
        child: Text(
          productId,
          style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
