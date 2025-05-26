import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/features/authentication/presentation/provider/auth_provider.dart';
import 'package:fashion_app/features/authentication/presentation/provider/auth_state.dart';
import 'package:fashion_app/features/cart/domain/entities/cart.dart';
import 'package:fashion_app/features/cart/presentation/provider/cart_provider.dart';
import 'package:fashion_app/features/products/domain/entities/products.dart';
import 'package:fashion_app/features/products/presentation/widgets/product_details.dart';
import 'package:fashion_app/features/settings/presentation/provider/favorite_provider.dart';
import 'package:fashion_app/features/settings/presentation/provider/favorite_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCard extends ConsumerStatefulWidget {
  final Products products;
  const ProductCard({
    super.key,
    required this.products,
  });

  @override
  ConsumerState<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final favoritesState = ref.watch(favoritesNotifierProvider);
    final notifier = ref.read(favoritesNotifierProvider.notifier);
    final authState = ref.read(authProvider);
    bool isAdded = false;

    bool isFavorite = favoritesState is FavoritesLoaded &&
        favoritesState.favorites
            .any((product) => product.id == widget.products.id);

    void addToCart() {
      final cartItem =
          CartItem(product: widget.products, total: widget.products.price);

      ref.read(cartProvider.notifier).addToCart(cartItem);

      setState(() {
        isAdded = !isAdded;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${widget.products.name} added to cart!')),
      );
    }

    if (authState is Authenticated) {
      final currentUser = authState.user;

      return InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductDetails(
                products: widget.products,
                userId: currentUser.uid,
              ),
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
                    height: 120,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.network(
                      widget.products.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/p.png');
                        // return const Center(
                        //   child: Icon(Icons.broken_image,
                        //       color: Colors.red, size: 50),
                        // );
                      },
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () async {
                        try {
                          if (favoritesState is! FavoritesLoading) {
                            await notifier.toggleFavorites(
                                currentUser.uid, widget.products.id);
                          }
                        } catch (e) {
                          print('Error toggling favorite: $e');
                        }
                      },
                      child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_outline,
                          color: isFavorite ? Colors.red : Colors.black),
                    ),
                  )
                ],
              ),
              AppText(
                text: widget.products.name,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
              AppText(
                text: '\$${widget.products.price.toStringAsFixed(2)}',
                fontSize: 12,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const Spacer(),
              Center(
                child: InkWell(
                  onTap: addToCart,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).colorScheme.tertiary),
                    child: AppText(
                      text: !isAdded ? "Add to cart" : 'Added!',
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 10,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
    return const SizedBox();
  }
}
