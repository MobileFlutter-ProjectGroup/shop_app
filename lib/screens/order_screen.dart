import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  final List<Orders> orders;
  const OrderScreen({
    super.key,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    final orderContainer = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) => OrderItem(
          orderContainer.items[index],
        ),
      ),
    );
  }
}
