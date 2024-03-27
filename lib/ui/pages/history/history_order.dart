import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pos_order/models/order.dart';
import 'package:pos_order/models/product.dart';

class HistoryOrder extends StatelessWidget {
  const HistoryOrder({super.key, required this.orderModel});
  final OrderModel orderModel;

  List<Widget> productDetailsList(Map<ProductModel, int> products) {
    final widgetList = <Widget>[];
    double fullPrice = 0;
    log('PRODUCTS: $products');

    products.forEach((product, quantity) {
      final price = product.price * quantity;
      widgetList.add(Text(
          'ТОВАР: ${product.name ?? ''} - ${product.price} руб x $quantity = $price руб'));
      fullPrice += price;
    });
    widgetList.add(Text('СТОЙМОСТЬ: $fullPrice руб'));
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    final products = orderModel.products;
    final order = productDetailsList(products);
    final tableId = orderModel.tablesId;
    return ExpansionTile(
      title: Text('ЗАКАЗ ${orderModel.id} СТОЛ: $tableId'),
      children: order,
    );
  }
}
