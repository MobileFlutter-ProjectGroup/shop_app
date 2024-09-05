import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';

import '../provider/orders.dart';
import '../widgets/order_item.dart' as ui;

class OrderScreen extends StatelessWidget {
  const OrderScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final orderContainer = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('My Orders'),
      ),
      body: ListView.builder(
          itemCount: orderContainer.items.length,
          itemBuilder: (ctx, index) =>
              ui.OrderItem(orderContainer.items[index])),
      drawer: const AppDrawer(),
    );
  }
}
