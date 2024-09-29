import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xffF2F2F2),
      child: Column(
        children: [
          const DrawerHeader(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 30,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'My Shop',
                  style: TextStyle(
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            leading: const Icon(
              Icons.shopping_cart_checkout_outlined,
              size: 30,
            ),
            title: const Text(
              'Shop',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/order');
            },
            leading: const Icon(
              Icons.add_shopping_cart,
              size: 30,
            ),
            title: const Text(
              'Order',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.favorite_border,
              size: 30,
            ),
            title: const Text(
              'Favorite',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/user-product');
            },
            leading: const Icon(
              Icons.edit,
              size: 30,
            ),
            title: const Text(
              'Manage Product',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
