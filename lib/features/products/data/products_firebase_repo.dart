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
  Future<void> toggleFavorite(String id) async {
    try {
      final productDoc = productsCollection.doc(id);
      final productSnapshot = await productDoc.get();
      if (productSnapshot.exists) {
        final data = productSnapshot.data() as Map<String, dynamic>;

        final isFavorite = data["isFavorite"] ?? false;

        await productDoc.update({'isFavorite': !isFavorite});
      } else {
        throw Exception('Product with id $id does not exist.');
      }
    } catch (e) {
      throw Exception('Failed to toggle favorite status: $e');
    }
  }

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
}
