import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/core/constants/progress_indicator.dart';
import 'package:fashion_app/features/products/presentation/provider/product_provider.dart';
import 'package:fashion_app/features/products/presentation/provider/product_state.dart';
import 'package:fashion_app/features/products/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllProductsGrid extends ConsumerStatefulWidget {
  const AllProductsGrid({super.key});

  @override
  ConsumerState<AllProductsGrid> createState() => _AllProductsGridState();
}

class _AllProductsGridState extends ConsumerState<AllProductsGrid> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(productProvider.notifier).loadAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productProvider);

    return productState is ProductLoading
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
                        text: 'All Products',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          itemCount: productState.products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.65,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20),
                          itemBuilder: (context, index) {
                            final product = productState.products[index];
                            return ProductCard(products: product);
                          })
                    ],
                  )
                : const Center(
                    child: Text('No products available.'),
                  );
  }
}
