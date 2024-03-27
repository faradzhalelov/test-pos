import 'package:flutter/material.dart';
import 'package:pos_order/models/order.dart';
import 'package:pos_order/models/product.dart';

class HistoryOrderItem extends StatelessWidget {
  const HistoryOrderItem({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final id = product.id;
    final name = product.name ?? 'ПРОДУКТ: $id';
    final price = product.price;
    return Text('Товар: $name == $price');
  }
}
