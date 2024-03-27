import 'package:pos_order/db/db_mixin.dart';

class DatabaseService with DBMixin {
  Future<List<Map<String, dynamic>>> getTables() async {
    final List<Map<String, dynamic>> table = await db.query('cafe_tables');
    return table;
  }

  Future getOrder() async {}

  Future addProduct() async {}

  Future<List<Map<String, dynamic>>> getProducts() async {
    final List<Map<String, dynamic>> table = await db.query('products');
    return table;
  }

  Future deleteProduct() async {}

  Future updateOrder() async {}

  Future deleteOrder() async {}

  Future getOrders() async {}

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
