import 'package:fashion_app/features/products/data/products_firebase_repo.dart';
import 'package:fashion_app/features/products/domain/repo/product_repo.dart';
import 'package:fashion_app/features/products/presentation/provider/product_notifier.dart';
import 'package:fashion_app/features/products/presentation/provider/product_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Product provider to expose the ProductNotifier
final productCategoryProvider =
    StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  final productRepo = ref.watch(productCategoryRepositoryProvider);
  return ProductNotifier(productRepo: productRepo);
});

final productCategoryRepositoryProvider = Provider<ProductRepo>((ref) {
  return ProductsFirebaseRepo();
});
