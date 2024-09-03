import 'package:flutter/material.dart';
import '../provider/orders.dart' as oi;
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final oi.OrderItem _orderItem;
  const OrderItem(
    this._orderItem, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Card(
        margin: const EdgeInsets.all(10.0),
        child: ListTile(
          title: Text('\$${_orderItem.total}'),
          subtitle: Text(
            DateFormat('dd-MM-yyyy hh:mm').format(_orderItem.dateTime),
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.expand_more,
                size: 25,
                color: Colors.black,
              )),
        ),
      ),
    );
  }
}
