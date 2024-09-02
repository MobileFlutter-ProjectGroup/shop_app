import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/cart.dart';
// import 'package:provider/provider.dart';
// import '../provider/products.dart';
import '../widgets/product_grid.dart';
import '../widgets/badge.dart';

enum ItemOption {
  all,
  favorite,
}

class ProductOverview extends StatefulWidget {
  const ProductOverview({super.key});

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    // final Products productContainer = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Product Overview'),
        actions: [
          Consumer<Cart>(
            builder: (_, cart, ch) => MyBadge(
              value: cart.itemCount().toString(),
              color: Colors.white,
              textColor: Colors.red,
              child: ch!,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart_outlined,
                size: 30,
                color: Colors.amber,
              ),
            ),
          ),
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              size: 30,
              color: Colors.black,
            ),
            onSelected: (value) {
              setState(() {
                if (value == ItemOption.favorite) {
                  // productContainer.setShowFavorite();
                  isFavorite = true;
                } else {
                  // productContainer.setShowAll();
                  isFavorite = false;
                }
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: ItemOption.all,
                onTap: () {},
                child: const Text(
                  'All',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              PopupMenuItem(
                value: ItemOption.favorite,
                onTap: () {},
                child: const Text(
                  'Favorite',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: ProductGridView(
        showFavoirte: isFavorite,
      ),
    );
  }
}
