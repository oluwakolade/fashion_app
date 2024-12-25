import 'package:fashion_app/features/cart/domain/entities/cart.dart';

abstract class CartState {}

class CartEmpty extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> cart;
  final double total;

  CartLoaded({required this.cart, required this.total});
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}
