import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/cart.dart' show Cart;
import '../provider/orders.dart';
import '../widgets/cart_item.dart' /*as ci*/;

class CartScreen extends StatelessWidget {
  // static String routeName = 'cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);
    final cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Chip(
                      label: Text(
                        '\$${cart.totalAmount}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                    ),
                    const Spacer(),
                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.deepPurple[200]),
                        onPressed: () {
                          Provider.of<Orders>(context, listen: false)
                              .addOrder(cartItems, cart.totalAmount);
                          cart.clearCart();
                        },
                        child: const Text(
                          'Order Now',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ))
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (ctx, index) => CartItem(
                id: cartItems[index].id,
                title: cartItems[index].title,
                quantity: cartItems[index].quantity,
                price: cartItems[index].price,
                image: cartItems[index].image,
                productId: cart.items.keys.toList()[index],
              ), // ci.CartItem(id: ,),
            ),
          )
        ],
      ),
    );
  }
}
