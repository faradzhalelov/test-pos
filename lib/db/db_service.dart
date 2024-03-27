import 'dart:developer';

import 'package:pos_order/db/db_mixin.dart';
import 'package:pos_order/models/product.dart';

class DatabaseService with DBMixin {
  Future<List<Map<String, dynamic>>> getTables() async {
    final List<Map<String, dynamic>> table = await db.query('cafe_tables');
    return table;
  }

  Future<void> addOrder({
    required int cafeTableId,
    required Map<ProductModel, int> products,
    String status = 'finished',
  }) async {
    await db.transaction((txn) async {
      final orderId = await txn.insert('orders', {
        'cafe_table_id': cafeTableId,
        'created_at': DateTime.now().toIso8601String(),
        'status': status,
      });

      var insertFutures = products.entries.map((e) {
        return txn.insert('order_products', {
          'order_id': orderId,
          'product_id': e.key.id,
          'quantity': e.value,
        });
      }).toList();

      await Future.wait(insertFutures);
    });
  }

  Future<Map<String, dynamic>> getOrderDetails(int orderId) async {
    // Получаем информацию о заказе и столе
    final List<Map<String, dynamic>> orderData = await db.rawQuery('''
      SELECT orders.*, cafe_tables.name as table_name
      FROM orders
      JOIN cafe_tables ON orders.cafe_table_id = cafe_tables.id
      WHERE orders.id = ?;
    ''', [orderId]);

    if (orderData.isEmpty) {
      throw Exception('Order not found');
    }

    // Получаем продукты, связанные с заказом
    final List<Map<String, dynamic>> productsData = await db.rawQuery('''
      SELECT products.*, order_products.quantity
      FROM order_products
      JOIN products ON order_products.product_id = products.id
      WHERE order_products.order_id = ?;
    ''', [orderId]);

    // Собираем и возвращаем детализированные данные о заказе
    return {
      'orderDetails': orderData.first,
      'products': productsData,
    };
  }

  Future<List<Map<String, dynamic>>> getAllOrders() async {
    final List<Map<String, dynamic>> orders = await db.rawQuery('''
      SELECT 
        o.id as order_id,
        o.created_at,
        o.status,
        ct.id as table_id,
        op.product_id,
        op.quantity,
        p.name as product_name,
        p.price,
        p.category
      FROM 
        orders o
      JOIN 
        cafe_tables ct ON o.cafe_table_id = ct.id
      JOIN 
        order_products op ON o.id = op.order_id
      JOIN 
        products p ON op.product_id = p.id
      ORDER BY 
        o.created_at DESC
    ''');

    return orders;
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    final List<Map<String, dynamic>> table = await db.query('products');
    return table;
  }

  Future getOrderHistory() async {}

  Future<List<Map<String, dynamic>>> getOrdersByTableId(int tableId) async {
    final List<Map<String, dynamic>> orders = await db.rawQuery('''
    SELECT 
      orders.id AS order_id,
      orders.created_at,
      orders.status,
      order_products.product_id,
      order_products.quantity,
      products.name AS product_name,
      products.price AS product_price
    FROM 
      orders
    JOIN 
      order_products ON orders.id = order_products.order_id
    JOIN 
      products ON order_products.product_id = products.id
    WHERE 
      orders.cafe_table_id = ?
    ORDER BY 
      orders.created_at DESC;
  ''', [tableId]);
    return orders;
  }
}
