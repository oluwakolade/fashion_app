import 'package:fashion_app/features/home/domain/entities/category.dart';

abstract class CategoryRepo {
  Future<List<Category>> getAllCategories();
}
