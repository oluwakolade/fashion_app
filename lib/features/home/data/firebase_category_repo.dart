import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/features/home/domain/entities/category.dart';
import 'package:fashion_app/features/home/domain/repo/category_repo.dart';

class FirebaseCategoryRepo implements CategoryRepo {
  final firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<List<Category>> getAllCategories() async {
    try {
      final snapshot = await firebaseFirestore.collection('categories').get();
      final list =
          snapshot.docs.map((doc) => Category.fromSnapshot(doc)).toList();
      return list;
    } catch (e) {
      throw e.toString();
    }
  }
}
