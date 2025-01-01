import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/core/constants/progress_indicator.dart';
import 'package:fashion_app/core/responsive/responsve_scaffold.dart';
import 'package:fashion_app/features/products/presentation/widgets/product_card.dart';
import 'package:fashion_app/features/settings/presentation/provider/favorite_provider.dart';
import 'package:fashion_app/features/settings/presentation/provider/favorite_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesState = ref.watch(favoritesNotifierProvider);

    return ResponsiveScaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Center(
            child: AppText(
              text: "Address",
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: favoritesState is FavoritesLoading
            ? const Center(
                child: AppLoadingIndicator(),
              )
            : favoritesState is FavoritesError
                ? const Center(
                    child: Text("Failed to load products"),
                  )
                : favoritesState is FavoritesLoaded
                    ? Expanded(
                        child: GridView.builder(
                            itemCount: 2,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 8,
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) {
                              final product = favoritesState.favorites[index];
                              return ProductCard(
                                products: product,
                              );
                            }),
                      )
                    : const SizedBox());
  }
}
