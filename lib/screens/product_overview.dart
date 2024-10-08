import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products.dart';
import '../widgets/app_drawer.dart';
import '../provider/cart.dart';
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
  bool _isInit = false;
  bool isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Products>(context).fetchAndAddProduct().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // Provider.of<Products>(context, listen: false).fetchAndAddProduct();
    _isInit = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final Products productContainer = Provider.of<Products>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFf2f2f2),
      appBar: AppBar(
        backgroundColor:
            const Color(0xff2299B4), //Theme.of(context).colorScheme.primary,
        title: const Text(
          'Product Overview',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/cart');
            },
            child: Consumer<Cart>(
              builder: (_, cart, ch) => MyBadge(
                value: cart.itemCount().toString(),
                color: Colors.white,
                textColor: Colors.red,
                child: ch!,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/cart');
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 40,
                  color: Colors.amber,
                ),
              ),
            ),
          ),
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              size: 30,
              color: Colors.white,
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductGridView(
              showFavoirte: isFavorite,
            ),
      drawer: const AppDrawer(),
    );
  }
}
