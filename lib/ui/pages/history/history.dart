import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pos_order/db/db_service.dart';
import 'package:pos_order/models/category.dart';
import 'package:pos_order/models/order.dart';
import 'package:pos_order/models/product.dart';
import 'package:pos_order/ui/components/drawer.dart';
import 'package:pos_order/ui/pages/history/history_order.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<OrderModel> orders = [];
  @override
  void initState() {
    super.initState();
    initHistory();
  }

  initHistory() async {
    final ordersFromDB = await DatabaseService().getAllOrders();
    orders.addAll(consolidateOrders(ordersFromDB));
    setState(() {});
  }

  List<OrderModel> consolidateOrders(List<Map<String, dynamic>> rawData) {
    Map<int, OrderModel> ordersMap = {};

    for (var row in rawData) {
      int orderId = row['order_id'];
      int tableId = row['table_id'];
      DateTime createdAt = DateTime.parse(row['created_at']);
      ProductModel product = ProductModel(
        id: row['product_id'],
        name: row['product_name'],
        price: row['price'],
        category: Category.values
            .firstWhere((element) => element.categoryName == row['category']),
      );
      int quantity = row['quantity'];

      if (!ordersMap.containsKey(orderId)) {
        ordersMap[orderId] = OrderModel(
          id: orderId,
          tablesId: tableId,
          products: {product: quantity},
          createdAt: createdAt,
        );
      } else {
        ordersMap[orderId]!.products.update(
              product,
              (existingQuantity) => existingQuantity + quantity,
              ifAbsent: () => quantity,
            );
      }
    }

    return ordersMap.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text('ИСТОРИЯ'),
              ...orders.map((e) => HistoryOrder(orderModel: e))
            ],
          ),
        ),
      ),
    );
  }
}
