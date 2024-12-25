import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/features/category/domain/entities/category.dart';
import 'package:fashion_app/features/category/domain/repo/category_repo.dart';

class FirebaseCategoryRepo implements CategoryRepo {
  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection('categories');

  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

//get main  categories
  @override
  Future<List<Category>> getAllCategories() async {
    try {
      final snapshot =
          await categoryCollection.orderBy('id', descending: true).get();

      final List<Category> allCategories =
          snapshot.docs.map((doc) => Category.fromFirestore(doc)).toList();

      return allCategories;
    } catch (e) {
      throw Exception('Could not fetch categories. Please try again.');
    }
  }

//feeatured categories

  // // Fetch products for a specific category (main or featured)
  // @override
  // Future<List<Products>> fetchProductsByCategory(String categoryId) async {
  //   try {
  //     final snapshot = await productsCollection
  //         .where('categoryIds', arrayContains: categoryId)
  //         .get();

  //     final List<Products> products =
  //         snapshot.docs.map((doc) => Products.fromFirestore(doc)).toList();
  //     return products;
  //   } catch (e) {
  //     throw 'Error fetching products: $e';
  //   }
  // }
}
