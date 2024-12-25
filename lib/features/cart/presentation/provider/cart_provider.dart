import 'package:fashion_app/features/cart/presentation/provider/cart_notifier.dart';
import 'package:fashion_app/features/cart/presentation/provider/cart_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});
