// class FeaturedCategoryScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final featuredCategoryState = ref.watch(categoryNotifierProvider);
//     final productState = ref.watch(productNotifierProvider);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Featured Categories')),
//       body: featuredCategoryState is CategoryLoading
//           ? const Center(child: CircularProgressIndicator())
//           : featuredCategoryState is CategoryLoaded
//               ? GridView.builder(
//                   itemCount: featuredCategoryState.featuredCategories.length,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2, // Adjust this based on your layout
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                   ),
//                   itemBuilder: (context, index) {
//                     final category = featuredCategoryState.featuredCategories[index];
//                     // Fetch products by category
//                     ref.read(productNotifierProvider.notifier).fetchProductsByCategory(category.id);

//                     // Check if products are loaded for the selected category
//                     if (productState is ProductLoading) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (productState is ProductLoaded) {
//                       final products = productState.products;
//                       return GridView.builder(
//                         itemCount: products.length,
//                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           crossAxisSpacing: 10,
//                           mainAxisSpacing: 10,
//                         ),
//                         itemBuilder: (context, productIndex) {
//                           final product = products[productIndex];
//                           return GestureDetector(
//                             onTap: () {
//                               // Navigate to product details page
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ProductDetailScreen(productId: product.id),
//                                 ),
//                               );
//                             },
//                             child: ProductCard(product: product),
//                           );
//                         },
//                       );
//                     } else {
//                       return const Center(child: Text('No products available.'));
//                     }
//                   },
//                 )
//               : const Center(child: Text('Failed to load categories.')),
//     );
//   }
// }
