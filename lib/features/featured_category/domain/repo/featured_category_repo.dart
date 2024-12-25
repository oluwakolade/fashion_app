import 'package:fashion_app/features/featured_category/domain/entities/featured_category.dart';

abstract class FeaturedCategoryRepo {
  Future<List<FeaturedCategory>> getFeaturedCategories();
}
