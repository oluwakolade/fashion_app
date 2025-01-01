import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/features/products/domain/entities/products.dart';
import 'package:fashion_app/features/products/presentation/provider/product_provider.dart';
import 'package:fashion_app/features/products/presentation/widgets/product_details.dart';
import 'package:fashion_app/features/settings/domain/entities/user.dart';
import 'package:fashion_app/features/settings/presentation/provider/favorite_provider.dart';
import 'package:fashion_app/features/settings/presentation/provider/favorite_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCard extends ConsumerWidget {
  final Products products;
  final User? user;
  const ProductCard({super.key, required this.products, this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetails(products: products),
          ),
        );
      },
      child: Container(
        height: double.infinity,
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 110,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.network(
                    products.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.broken_image,
                            color: Colors.red, size: 50),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Consumer(builder: (context, ref, child) {
                    final favoritesState = ref.watch(favoritesNotifierProvider);
                    final notifier =
                        ref.read(favoritesNotifierProvider.notifier);

                    bool isFavorite = favoritesState is FavoritesLoaded &&
                        favoritesState.favorites
                            .any((product) => product.id == products.id);

                    return InkWell(
                      onTap: () async {
                        if (favoritesState is! FavoritesLoading) {
                          await notifier.toggleFavorites(
                              user!.uid, products.id);
                        }
                      },
                      child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_outline,
                          color: isFavorite ? Colors.red : Colors.black),
                    );
                  }),
                )
              ],
            ),
            const Spacer(),
            AppText(
              text: products.name,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
            AppText(
              text: '\$${products.price.floorToDouble()}',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
