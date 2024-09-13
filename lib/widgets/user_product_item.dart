import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageURL;
  final double price;

  const UserProductItem({
    super.key,
    required this.id,
    required this.title,
    required this.imageURL,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    void onDismissedEdit() {
      Navigator.of(context).pushNamed(
        '/edit-product',
        arguments: id,
      );
    }

    void onDismissedDelete() {
      Provider.of<Products>(context, listen: false).deleteProduct(id);
    }

    return Slidable(
      startActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          backgroundColor: Colors.green,
          onPressed: (context) => onDismissedEdit(),
          icon: Icons.edit,
          label: 'Edit',
        ),
        SlidableAction(
          icon: Icons.delete,
          backgroundColor: Colors.red,
          onPressed: (context) => onDismissedDelete(),
        )
      ]),
      child: ListTile(
        onLongPress: () {},
        leading: Container(
          width: 60,
          height: 50,
          padding: const EdgeInsets.all(5),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.grey[300],
          ),
          child: Image.network(
            imageURL,
            fit: BoxFit.cover,
          ), //NetworkImage(imageURL),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        trailing: SizedBox(
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$$price',
                style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              const Text(
                'Unlimited',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
