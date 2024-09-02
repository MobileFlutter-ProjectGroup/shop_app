import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String image;
  final String productId;
  const CartItem({
    super.key,
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.image,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          size: 30,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        elevation: 1,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(image),
          ),
          title: Text(title),
          subtitle: Text('\$$price'),
          trailing: Text('$quantity pcs'),
        ),
      ),
    );
  }
}
