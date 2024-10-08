import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../../widgets/user_product_item.dart';

import '../provider/products.dart';

class UserProduct extends StatelessWidget {
  const UserProduct({super.key});

  Future<void> _refreshHandaler(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndAddProduct(true);
  }

  @override
  Widget build(BuildContext context) {
    //final productContainer = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'User Product',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.qr_code_scanner_outlined,
              size: 30.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
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
                // Text(
                //   'Products (${productContainer.items.length})',
                //   style: const TextStyle(
                //     fontSize: 18.0,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.black,
                //   ),
                // ),
                const SizedBox(
                  height: 5.0,
                ),
                Container(
                  // margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  height: 55,
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
            child: FutureBuilder(
              future: _refreshHandaler(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () => _refreshHandaler(context),
                    child: Consumer<Products>(
                      builder: (ctx, productContainer, __) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: productContainer.items.length,
                          itemBuilder: (_, index) => UserProductItem(
                            id: productContainer.items[index].id,
                            title: productContainer.items[index].title,
                            imageURL: productContainer.items[index].image,
                            price: productContainer.items[index].price,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
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
          Navigator.of(context).pushNamed('/edit-product', arguments: '');
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
