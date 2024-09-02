import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/cart.dart';
import 'screens/product_overview.dart';
import 'widgets/produt_item.dart';
import 'screens/product_detail.dart';
import 'provider/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //value:Products
        ChangeNotifierProvider<Products>(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider<Cart>(
          create: (_) => Cart(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Online Shop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ProductOverview(),
        routes: {
          ProdutItem.routeName: (context) => const ProductDetail(),
        },
      ),
    );
  }
}
