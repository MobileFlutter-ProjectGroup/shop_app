import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../../widgets/user_product_item.dart';

import '../provider/products.dart';

class UserProduct extends StatelessWidget {
  const UserProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final productContainer = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('User Product'),
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: const Icon(
        //         Icons.add,
        //         size: 30.0,
        //       ))
        // ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.greenAccent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Products (${productContainer.items.length})',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  height: 60,
                  width: double.infinity,
                  child: const TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Barcode/Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.search)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productContainer.items.length,
              itemBuilder: (_, index) => UserProductItem(
                title: productContainer.items[index].title,
                imageURL: productContainer.items[index].image,
                price: productContainer.items[index].price,
              ),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.purple,
        onPressed: () {
          Navigator.of(context).pushNamed('/edit-product');
        },
        child: const Icon(
          Icons.add,
          size: 30.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
