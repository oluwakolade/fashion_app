import 'package:fashion_app/features/featured_category/domain/entities/featured_category.dart';
import 'package:fashion_app/features/products/domain/entities/products.dart';

abstract class FeaturedCategoryState {}

//loading

class FeatureLoading extends FeaturedCategoryState {}

//loaded
class FeatureLoaded extends FeaturedCategoryState {
  final List<FeaturedCategory> features;

  FeatureLoaded(this.features);
}

class FeatureError extends FeaturedCategoryState {
  final String message;

  FeatureError(this.message);
}

class FeatureProductsLoaded extends FeaturedCategoryState {
  final List<Products> products;

  FeatureProductsLoaded(this.products);
}
