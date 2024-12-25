import 'package:fashion_app/features/category/domain/repo/category_repo.dart';
import 'package:fashion_app/features/category/presentation/provider/category_state.dart';
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

      await Future.delayed(Duration.zero, () async {
        final categories = await categoryRepo.getAllCategories();
        //update category list
        state = CategoryLoaded(categories);
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Load products based on the category (main or featured)
  // void loadCategoryProducts(String categoryId) async {
  //   try {
  //     state = CategoryLoading();
  //     final products = await categoryRepo.fetchProductsByCategory(categoryId);
  //     state = CategoryProductsLoaded(products);
  //   } catch (e) {
  //     state = CategoryError(e.toString());
  //   }
  // }
}







  // Future<void> loadCategoryProducts(String categoryId) async {
  //   try {
  //     state = CategoryLoading();
  //     final products = await categoryRepo.getCategoryProducts(categoryId);
  //     state = CategoryProductsLoaded(categoryId, products);
  //   } catch (e) {
  //     state = CategoryError(e.toString());
  //   }
  // }

  // // Load products for a featured category (e.g., New In, Popular Products)
  // Future<void> loadFeaturedProducts(String featuredTag) async {
  //   try {
  //     state = CategoryLoading();
  //     final products = await categoryRepo.getFeaturedProducts(featuredTag);
  //     state = CategoryFeaturedProductsLoaded(featuredTag, products);
  //   } catch (e) {
  //     state = CategoryError(e.toString());
  //   }
  // }

  // Future<List<Category>> loadFeaturedCategories() async {
  //   try {
  //     final categories = await categoryRepo.fetchFeaturedCategories();
  //     return categories;
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }


  
  // // Load products for a specific main or featured category
  // void fetchCategoryProducts(String categoryId) async {
  //   try {
  //     state = CategoryLoading();
  //     final products = await categoryRepo.getCategoryProducts(categoryId);
  //     state = CategoryLoaded(categoryId, products);
  //   } catch (e) {
  //     state = CategoryError(e.toString());
  //   }
  // }
  
  // // Load products for featured categories like "New In" or "Popular"
  // void fetchFeaturedCategoryProducts(String featuredType) async {
  //   try {
  //     state = CategoryLoading();
  //     final products = await categoryRepo.getFeaturedCategoryProducts(featuredType);
  //     state = CategoryLoaded(featuredType, products);
  //   } catch (e) {
  //     state = CategoryError(e.toString());
  //   }
  // }
