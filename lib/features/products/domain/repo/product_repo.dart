import 'package:fashion_app/features/products/domain/entities/products.dart';

abstract class ProductRepo {
  Future<List<Products>> fetchAllProducts();
  Future<void> addtoCart(String id);
  Future<void> removeFromCart(String id);
  Future<List<Products>> getProductsByCategory(String categoryId);
  Future<List<Products>> getProductsByFeature(String feature);
  Future<List<Products>> getProductsById(String id);
  // Future<List<Products>> getUserFavorites(String uid);
}
