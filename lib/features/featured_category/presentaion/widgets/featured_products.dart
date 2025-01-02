import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/core/constants/progress_indicator.dart';
import 'package:fashion_app/features/products/presentation/provider/product_provider.dart';
import 'package:fashion_app/features/products/presentation/provider/product_state.dart';
import 'package:fashion_app/features/products/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeaturedProducts extends ConsumerStatefulWidget {
  final String featureName;

  const FeaturedProducts({
    super.key,
    required this.featureName,
  });

  @override
  ConsumerState<FeaturedProducts> createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends ConsumerState<FeaturedProducts> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref
          .read(productProvider.notifier)
          .loadProductsbyFeature(widget.featureName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productProvider);

    return SizedBox(
      height: 300,
      child: productState is ProductLoading
          ? const Center(
              child: AppLoadingIndicator(),
            )
          : productState is ProductError
              ? Center(child: Text('Error: ${productState.message}'))
              : productState is ProductLoaded
                  ? Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: widget.featureName,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        Expanded(
                          child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: productState.products.length,
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 1.75),
                              itemBuilder: (context, index) {
                                final product = productState.products[index];

                                return ProductCard(products: product);
                              }),
                        )
                      ],
                    )
                  : const Center(
                      child: Text('No products available.'),
                    ),
    );
  }
}
