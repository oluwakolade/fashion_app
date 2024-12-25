import 'package:fashion_app/features/category/domain/entities/category.dart';

abstract class CategoryRepo {
  Future<List<Category>> getAllCategories();
  // Future<List<Products>> fetchProductsByCategory(String categoryId);
}
