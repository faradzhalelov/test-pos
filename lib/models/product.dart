// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'category.dart';

class ProductModel {
  final int id;
  final String? name;
  final Category category;
  final double price;
  ProductModel({
    required this.id,
    this.name,
    required this.category,
    required this.price,
  });

  ProductModel copyWith({
    int? id,
    String? name,
    Category? category,
    double? price,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
    );
  }

  factory ProductModel.fromDB(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? -1,
      name: map['name'] ?? '',
      category: Category.values
          .firstWhere((element) => element.categoryName == map['category']),
      price: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name ?? '',
      'category': category.categoryName,
      'price': price,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['name'] != null ? map['name'] as String : null,
      category: Category.values.firstWhere(
          (element) => element.categoryName == map['category'] as String),
      price: map['price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, category: $category, price: $price)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.category == category &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ category.hashCode ^ price.hashCode;
  }
}
