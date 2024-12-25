import 'package:fashion_app/features/category/data/firebase_category_repo.dart';
import 'package:fashion_app/features/category/presentation/provider/category_notifier.dart';
import 'package:fashion_app/features/category/presentation/provider/category_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, CategoryState>((ref) {
  final categoryRepo = FirebaseCategoryRepo();
  return CategoryNotifier(categoryRepo: categoryRepo);
});

// final categoryProductsProvider = FutureProvider.family<List<Products>, String>(
//   (ref, categoryId) async {
//     final productRepository = ref.watch(productRepositoryProvider);
//     return await productRepository.fetchProductsByCategory(categoryId);
//   },
// );

// final productsCategoryProvider = StateNotifierProvider.autoDispose
//     .family<CategoryProductsNotifier, List<Products>, String>(
//         (ref, categoryId) {
//   final productRepo = ref.watch(productRepositoryProvider);
//   final notifier = CategoryProductsNotifier(productRepo: productRepo);
//   notifier.loadProductsByCategory(categoryId); // Trigger fetch
//   return notifier;
// });

// final categoryProductsNotifierProvider = StateNotifierProvider.autoDispose
//     .family<CategoryProductsNotifier, AsyncValue<List<Products>>, String>(
//   (ref, categoryId) {
//     final productRepo = ref.watch(productRepositoryProvider);
//     final notifier = CategoryProductsNotifier(productRepo: productRepo);
//     notifier.loadProductsByCategory(categoryId); // Trigger fetch
//     return notifier;
//   },
// );
