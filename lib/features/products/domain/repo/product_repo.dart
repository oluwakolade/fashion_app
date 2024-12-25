import 'package:fashion_app/features/products/domain/entities/products.dart';

abstract class ProductRepo {
  Future<List<Products>> fetchAllProducts();
  Future<void> toggleFavorite(String id);
  Future<void> addtoCart(String id);
  Future<void> removeFromCart(String id);
  // Future<void> getTotal(String id);
  // Future<void> getColor(String id);
  // Future<void> getSize(String id);
  Future<List<Products>> getProductsByCategory(String categoryId);
  Future<List<Products>> getProductsByFeature(String feature);
}
