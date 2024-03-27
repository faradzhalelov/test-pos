import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pos_order/db/db_service.dart';
import 'package:pos_order/models/product.dart';

import 'item_widget.dart';

class TableDetails extends StatefulWidget {
  const TableDetails({super.key, required this.id});

  final int id;

  @override
  State<TableDetails> createState() => _TableDetailsState();
}

class _TableDetailsState extends State<TableDetails> {
  int get id => widget.id;
  List<ProductModel> products = [];
  Map<ProductModel, int> order = {};
  @override
  void initState() {
    super.initState();
    initTablesFromDb();
  }

  initTablesFromDb() async {
    //final ordersFromDb = await DatabaseService().getOrdersByTableId(id);
    final productsFromDB = await DatabaseService().getProducts();
    log('PRODUCTS: $productsFromDB');
    products = productsFromDB.map((m) => ProductModel.fromDB(m)).toList();
    //tables = data.map((m) => TableModel.fromDB(m)).toList();

    setState(() {});
  }

  addOrder(ProductModel product) {
    if (order.containsKey(product)) {
      order[product] = order[product]! + 1;
    } else {
      order[product] = 1;
    }
  }

  deleteOrder(ProductModel product) {
    if (order.containsKey(product)) {
      if (order[product]! > 1) {
        order[product] = order[product]! - 1;
      } else {
        order.remove(product);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(
        children: [
          Text('CТОЛ $id'),
          const Text('ТОВАРЫ'),
          Expanded(
            child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final productData = products[index];
                  final productId = productData.id;
                  final category = productData.category.name;
                  final name = productData.name ?? 'Unknown $productId';
                  final price = productData.price;
                  return ItemWidget(
                    category: category,
                    name: name,
                    price: price,
                    onTapPlus: () {
                      addOrder(productData);
                      setState(() {});
                    },
                    // onTapMinus: () {
                    //   deleteOrder(productData);
                    //   setState(() {});
                    // },
                  );
                }),
          ),
          const SizedBox(
            height: 10,
          ),
          order.isEmpty
              ? const SizedBox.shrink()
              : Flexible(
                  child: Container(
                    color: Colors.yellow,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: order.length,
                        itemBuilder: (context, index) {
                          final orderMap = order.entries.elementAt(index);
                          final count = orderMap.value;
                          final orderData = orderMap.key;
                          final productId = orderData.id;
                          final category = orderData.category.name;
                          final name = orderData.name ?? 'Unknown $productId';
                          final price = orderData.price;
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ItemWidget(
                                category: category,
                                name: name,
                                price: price,
                                onTapPlus: () {
                                  addOrder(orderData);
                                  setState(() {});
                                },
                                onTapMinus: () {
                                  deleteOrder(orderData);
                                  setState(() {});
                                },
                              ),
                              Text('КОЛВО: $count')
                            ],
                          );
                        }),
                  ),
                ),
          TextButton(
              onPressed: () {
                order.clear();
                setState(() {});
                context.go('/history');
              },
              child: const Text('СОХРАНИТЬ'))
        ],
      ),
    );
  }
}
