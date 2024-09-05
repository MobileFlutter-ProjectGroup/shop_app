import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageURL;
  final double price;

  const UserProductItem({
    super.key,
    required this.title,
    required this.imageURL,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Image.asset(
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
    );
  }
}
