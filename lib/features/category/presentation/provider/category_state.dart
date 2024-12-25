import 'package:fashion_app/features/category/domain/entities/category.dart';
import 'package:fashion_app/features/featured_category/domain/entities/featured_category.dart';
import 'package:fashion_app/features/products/domain/entities/products.dart';

abstract class CategoryState {}

//loading

class CategoryLoading extends CategoryState {}

//loaded
class CategoryLoaded extends CategoryState {
  final List<Category> category;

  CategoryLoaded(this.category);
}

class FeaturedCategoryLoaded extends CategoryState {
  final List<FeaturedCategory> featuredCategory;

  FeaturedCategoryLoaded(this.featuredCategory);
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message);
}

class CategoryProductsLoaded extends CategoryState {
  final List<Products> products;

  CategoryProductsLoaded(this.products);
}

class CategoryFeaturedProductsLoaded extends CategoryState {
  final String featuredTag;
  final List<Products> products;

  CategoryFeaturedProductsLoaded(this.featuredTag, this.products);
}
