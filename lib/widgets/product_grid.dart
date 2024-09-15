import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';
import '../provider/products.dart';
import 'produt_item.dart';

class ProductGridView extends StatelessWidget {
  final bool showFavoirte;
  const ProductGridView({
    super.key,
    required this.showFavoirte,
  });

  @override
  Widget build(BuildContext context) {
    final Products productData = Provider.of<Products>(context);
    final List<Product> products =
        showFavoirte ? productData.favorites : productData.items;

    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: const ProdutItem(),
      ),
    );
  }
}
