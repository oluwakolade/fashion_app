import 'package:fashion_app/features/products/domain/repo/product_repo.dart';
import 'package:fashion_app/features/products/presentation/provider/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductRepo productRepo;

  ProductNotifier({
    required this.productRepo,
  }) : super(ProductLoading());

  Future<void> loadAllProducts() async {
    try {
      //throw loader while loading products
      state = ProductLoading();
      //fetch products from data source api/firestore

      await Future.delayed(Duration.zero, () async {
        final products = await productRepo.fetchAllProducts();
        //update products list
        state = ProductLoaded(products: products);
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //toggle likes
  Future<void> toggleLikes(String id) async {
    try {
      await productRepo.toggleFavorite(id);
    } catch (e) {
      state = ProductError("Failed to Like");
    }
  }

  // Fetch products for a specific feature
  Future<void> loadProductsbyFeature(String feature) async {
    try {
      state = ProductLoading();
      final products = await productRepo.getProductsByFeature(feature);
      state = ProductLoaded(products: products);
    } catch (e) {
      state = ProductError(e.toString());
    }
  }

  //fetch product by category

  Future<void> loadProductsbyCategory(String categoryId) async {
    try {
      state = ProductLoading();
      final products = await productRepo.getProductsByCategory(categoryId);
      state = ProductLoaded(products: products);
    } catch (e) {
      state = ProductError(e.toString());
    }
  }

// get the total price
  Future<void> getTotal(double price, int quantity) async {
    try {
      if (state is ProductLoaded) {
        final products = (state as ProductLoaded).products;
        final total = price * quantity;

        // Update state with the new total
        state = ProductLoaded(
          products: products,
          total: total,
        );
      }
    } catch (e) {
      state = ProductError("Failed ");
    }
  }

  void selectSize(String size) {
    if (state is ProductLoaded) {
      final products = (state as ProductLoaded).products;
      state = ProductLoaded(
        products: products,
        selectedSize: size,
      );
    }
  }

  void selectColor(Color color) {
    if (state is ProductLoaded) {
      final products = (state as ProductLoaded).products;
      state = ProductLoaded(
        products: products,
        selectedColor: color,
      );
    }
  }
}
