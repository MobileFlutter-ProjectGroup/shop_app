import 'dart:math';

import 'package:flutter/material.dart';
import '../provider/orders.dart' as oi;
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final oi.OrderItem _orderItem;
  const OrderItem(
    this._orderItem, {
    super.key,
  });

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  final bool _expand = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ExpansionTile(
            title: ListTile(
              leading: Text(
                '\$${widget._orderItem.total}',
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              title: Text(
                DateFormat('dd-MM-yyyy').format(widget._orderItem.dateTime),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Slip :${widget._orderItem.id}',
              ),
              trailing:
                  Text('Item ${widget._orderItem.products.length.toString()}'),
            ),
            trailing: Icon(
              !_expand ? Icons.arrow_drop_down : Icons.arrow_drop_up,
            ),
            children: widget._orderItem.products
                .map(
                  (p) => Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          p.title,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${p.quantity} x \$${p.price}',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
