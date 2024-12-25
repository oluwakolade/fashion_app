import 'package:fashion_app/features/products/domain/entities/products.dart';
import 'package:flutter/material.dart';

abstract class ProductState {}

//loading

class ProductLoading extends ProductState {}

//loaded
class ProductLoaded extends ProductState {
  final List<Products> products;
  final double? total;
  final String? selectedSize;
  final Color? selectedColor;

  ProductLoaded(
      {required this.products,
      this.total,
      this.selectedSize,
      this.selectedColor});
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
