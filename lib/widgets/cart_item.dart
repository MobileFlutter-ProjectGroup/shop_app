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
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Are you sure to delete!'),
            // content: const Text(
            //     'You are trying delete this cart item.Please check again?'),
            actions: [
              TextButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.deepPurple),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  )),
              TextButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.deepPurple),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    'confirm',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  )),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        color: const Color(0xffc6caeb),
        elevation: 1,
        child: ListTile(
          leading: Container(
            height: 100,
            width: 50,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Image.network(image),
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Row(
            children: [
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: const Color(0xffafa5cf)),
                  onPressed: () {},
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
              const SizedBox(
                width: 10,
              ),
              Chip(
                label: Text('$quantity'),
              ),
              const SizedBox(
                width: 20,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xffafa5cf),
                  ),
                  onPressed: () {},
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ))
            ],
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Price',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                '\$$price',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
