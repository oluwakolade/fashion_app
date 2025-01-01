import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/features/products/domain/entities/products.dart';
import 'package:fashion_app/features/products/domain/repo/product_repo.dart';

class ProductsFirebaseRepo extends ProductRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('cart');

  final CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  //featch products

  @override
  Future<List<Products>> fetchAllProducts() async {
    try {
      final snapshot =
          await productsCollection.orderBy('id', descending: true).get();
      final List<Products> allProducts =
          snapshot.docs.map((doc) => Products.fromFirestore(doc)).toList();

      return allProducts;
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  // Fetch product by ID

  @override
  Future<List<Products>> getProductsById(String id) async {
    try {
      final snapshot =
          await productsCollection.where('id', isEqualTo: id).get();

      // final snapshot = await productsCollection.doc(id).get();

      final List<Products> allProductsbyId =
          snapshot.docs.map((doc) => Products.fromFirestore(doc)).toList();

      return allProductsbyId;
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  @override
  // Fetch products for a specific feature
  Future<List<Products>> getProductsByFeature(String feature) async {
    final productsQuery =
        await productsCollection.where('feature', isEqualTo: feature).get();

    return productsQuery.docs
        .map((doc) => Products.fromFirestore(doc))
        .toList();
  }

//get products by category
  @override
  Future<List<Products>> getProductsByCategory(String categoryId) async {
    final productQuery = await productsCollection
        .where("categoryId", isEqualTo: categoryId)
        .get();

    return productQuery.docs.map((doc) => Products.fromFirestore(doc)).toList();
  }

//toggle products fav

  @override
  Future<void> addtoCart(String id) async {
    try {
      // Assuming you have a 'cart' collection or cart document in Firestore
      final cartCollection = firestore.collection('cart');
      final productDoc = await productsCollection.doc(id).get();

      if (productDoc.exists) {
        final productData = productDoc.data() as Map<String, dynamic>;
        final cartDoc = cartCollection.doc(id);

        // Check if the product is already in the cart
        final cartSnapshot = await cartDoc.get();
        if (cartSnapshot.exists) {
          // Increment the quantity if the product already exists in the cart
          await cartDoc.update({'quantity': FieldValue.increment(1)});
        } else {
          // Add the product to the cart with an initial quantity of 1
          await cartDoc.set({...productData, 'quantity': 1});
        }
      } else {
        throw Exception('Product with id $id does not exist.');
      }
    } catch (e) {
      throw Exception('Failed to add product to cart: $e');
    }
  }

  @override
  Future<void> removeFromCart(String id) async {
    try {
      final cartDoc = await cartCollection.doc(id).get();
      if (cartDoc.exists) {
        await cartDoc.reference.delete(); // Delete the product from the cart
      } else {
        throw Exception("Product not found in cart.");
      }
    } catch (e) {
      throw Exception("Failed to remove product from cart: $e");
    }
  }

  // @override
  // Future<List<Products>> getUserFavorites(String uid) async {
  //   try {
  //     final userDoc = await usersCollection.doc(uid).get();

  //     if (userDoc.exists) {
  //       final userData = userDoc.data() as Map<String, dynamic>;
  //       final favorites = List<String>.from(userData['favorites'] ?? []);

  //       if (favorites.isEmpty) {
  //         return [];
  //       }

  //       final snapshot = await productsCollection
  //           .where(FieldPath.documentId, whereIn: favorites)
  //           .get();

  //       return snapshot.docs.map((doc) => Products.fromFirestore(doc)).toList();
  //     } else {
  //       throw Exception('User with ID $uid not found.');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to fetch user favorites: $e');
  //   }
  // }
}
