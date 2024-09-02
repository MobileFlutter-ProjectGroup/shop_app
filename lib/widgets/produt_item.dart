import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';
import '../provider/product.dart';

class ProdutItem extends StatelessWidget {
  static const String routeName = '/product-detail';

  // final String id;
  // final String image;
  // final String productTitle;

  const ProdutItem({
    super.key,
    // required this.image,
    // required this.productTitle,
    // required this.id,
  });
  void navigateProductDetail(BuildContext context, String id) {
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (_) => ProductDetail(id: id, title: productTitle),
    // ));
    Navigator.of(context).pushNamed(routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context, listen: false);
    final Cart cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              onPressed: product.toggleFavorite,
              icon: Icon(
                product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                size: 30,
              ),
              color: Colors.deepOrangeAccent,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(
                product.id.toString(),
                product.title,
                product.price,
                product.image,
              );
            },
            icon: const Icon(
              Icons.add_shopping_cart,
              size: 30,
            ),
            color: Colors.amber,
          ),
          title: Text(
            product.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        child: GestureDetector(
          onTap: () => navigateProductDetail(
            context,
            product.id.toString(),
          ),
          child: Image.asset(
            product.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
