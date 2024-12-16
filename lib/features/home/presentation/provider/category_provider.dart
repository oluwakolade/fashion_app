import 'package:fashion_app/features/home/data/firebase_category_repo.dart';
import 'package:fashion_app/features/home/presentation/provider/category_notifier.dart';
import 'package:fashion_app/features/home/presentation/provider/category_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, CategoryState>((ref) {
  final categoryRepo = FirebaseCategoryRepo();
  return CategoryNotifier(categoryRepo: categoryRepo);
});
