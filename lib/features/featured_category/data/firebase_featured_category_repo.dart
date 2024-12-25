import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/features/featured_category/domain/entities/featured_category.dart';
import 'package:fashion_app/features/featured_category/domain/repo/featured_category_repo.dart';

class FirebaseFeaturedCategoryRepo implements FeaturedCategoryRepo {
  final CollectionReference featuredCategoryCollection =
      FirebaseFirestore.instance.collection('featured_categories');

  @override
  Future<List<FeaturedCategory>> getFeaturedCategories() async {
    try {
      final snapshot = await featuredCategoryCollection
          .orderBy('id', descending: true)
          .get();

      final List<FeaturedCategory> featuredCategories = snapshot.docs
          .map((doc) => FeaturedCategory.fromFirestore(doc))
          .toList();

      return featuredCategories;
    } catch (e) {
      throw Exception('Could not fetch categories. Please try again.');
    }
  }
}
