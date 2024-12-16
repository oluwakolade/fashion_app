import 'package:fashion_app/features/home/domain/repo/category_repo.dart';
import 'package:fashion_app/features/home/presentation/provider/category_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryNotifier extends StateNotifier<CategoryState> {
  final CategoryRepo categoryRepo;

  CategoryNotifier({required this.categoryRepo}) : super(CategoryLoading());
  //LOAD ALL CATEGORIES
  Future<void> loadAllCategories() async {
    try {
      //throw loader while loading categories
      state = CategoryLoading();

      //fetch category from data source api/firestore
      final categories = await categoryRepo.getAllCategories();
      //update category list
      state = CategoryLoaded(categories);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
