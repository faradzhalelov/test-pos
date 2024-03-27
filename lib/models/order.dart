// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'product.dart';

class OrderModel {
  final int id;
  final int tablesId;
  final List<ProductModel> products;
  final DateTime createdAt;
  OrderModel({
    required this.id,
    required this.tablesId,
    required this.products,
    required this.createdAt,
  });

  OrderModel copyWith({
    int? id,
    int? tablesId,
    List<ProductModel>? products,
    DateTime? createdAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      tablesId: tablesId ?? this.tablesId,
      products: products ?? this.products,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tablesId': tablesId,
      'products': products.map((x) => x.toMap()).toList(),
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as int,
      tablesId: map['tablesId'] as int,
      products: List<ProductModel>.from(
        (map['products'] as List<int>).map<ProductModel>(
          (x) => ProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, tablesId: $tablesId, products: $products, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.tablesId == tablesId &&
        listEquals(other.products, products) &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        tablesId.hashCode ^
        products.hashCode ^
        createdAt.hashCode;
  }
}
