import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/cart_screen.dart';
import '../screens/order_screen.dart';
import '../screens/user_product.dart';
import 'provider/auth.dart';
import 'provider/cart.dart';
import 'provider/orders.dart';
import 'screens/auth_screen.dart';
import 'screens/edit_product_screen.dart';
import 'screens/product_overview.dart ';
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
        ChangeNotifierProvider<Auth>(
          create: (context) => Auth(),
        ),
        //value:Products
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(),
          update: (context, auth, previousProducts) => Products.update(
            auth.token!,
            auth.userId!,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider<Cart>(
          create: (_) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) => Orders(),
          update: (context, auth, previousOrders) => Orders.update(
            auth.token,
            previousOrders == null ? [] : previousOrders.items,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Online Shop App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: auth.isAuth ? const ProductOverview() : const AuthScreen(),
          routes: {
            '/product-detail': (context) => const ProductDetail(),
            '/cart': (context) => const CartScreen(),
            '/order': (context) => const OrderScreen(),
            '/user-product': (context) => const UserProduct(),
            '/edit-product': (context) => const EditProductScreen(),
          },
        ),
      ),
    );
  }
}
