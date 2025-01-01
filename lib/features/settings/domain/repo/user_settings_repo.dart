import 'package:fashion_app/features/products/domain/entities/products.dart';
import 'package:fashion_app/features/settings/domain/entities/user.dart';

abstract class SettingsRepo {
  Future<User?> fetchUserProfile(String uid);
  Future<void> updateUserProfile(User updateUser);
  Future<void> toggleFavorite(String uid, String id);
  Future<List<Products>> getUserFavorites(String uid);
}
