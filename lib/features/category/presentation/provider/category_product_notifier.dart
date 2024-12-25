import 'package:fashion_app/features/products/domain/entities/products.dart';
import 'package:fashion_app/features/products/domain/repo/product_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryProductsNotifier extends StateNotifier<List<Products>> {
  final ProductRepo productRepo;

  CategoryProductsNotifier({required this.productRepo}) : super([]);

  // Future<void> loadProductsByCategory(String categoryId) async {
  //   try {
  //     final products = await productRepo.fetchProductsByCategory(categoryId);
  //     state = products;
  //   } catch (e) {
  //     state = []; // Handle error (or provide a more robust mechanism)
  //   }
  // }
}
