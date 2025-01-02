import 'package:fashion_app/features/products/domain/entities/products.dart';
import 'package:flutter/material.dart';

class CartItem {
  final Products product;
  final String size;
  final Color color;
  final int quantity;
  final double total;

  CartItem(
      {required this.product,
      this.size = 'S',
      this.color = Colors.black,
      this.quantity = 1,
      required this.total});

  CartItem copyWith({
    Products? product,
    String? size,
    Color? color,
    int? quantity,
    double? total,
  }) {
    return CartItem(
        product: product ?? this.product,
        size: size ?? this.size,
        color: color ?? this.color,
        quantity: quantity ?? this.quantity,
        total: total ?? this.total);
  }
}
