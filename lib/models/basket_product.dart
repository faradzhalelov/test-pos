// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BasketProductModel {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  BasketProductModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
  });

  BasketProductModel copyWith({
    int? id,
    int? orderId,
    int? productId,
    int? quantity,
  }) {
    return BasketProductModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'orderId': orderId,
      'productId': productId,
      'quantity': quantity,
    };
  }

  factory BasketProductModel.fromMap(Map<String, dynamic> map) {
    return BasketProductModel(
      id: map['id'] as int,
      orderId: map['orderId'] as int,
      productId: map['productId'] as int,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory BasketProductModel.fromJson(String source) =>
      BasketProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BasketProduct(id: $id, orderId: $orderId, productId: $productId, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant BasketProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.orderId == orderId &&
        other.productId == productId &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        orderId.hashCode ^
        productId.hashCode ^
        quantity.hashCode;
  }
}
