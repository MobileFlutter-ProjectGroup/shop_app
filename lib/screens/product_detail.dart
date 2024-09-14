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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              child: Container(
                margin: const EdgeInsets.all(10.0),
                child: Text(
                  product.description,
                  textAlign: TextAlign.start,
                  softWrap: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
