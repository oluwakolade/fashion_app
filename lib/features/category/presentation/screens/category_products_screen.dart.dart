import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/core/constants/progress_indicator.dart';
import 'package:fashion_app/core/responsive/responsve_scaffold.dart';
import 'package:fashion_app/features/category/domain/entities/category.dart';
import 'package:fashion_app/features/products/presentation/provider/product_category_provider.dart';
import 'package:fashion_app/features/products/presentation/provider/product_state.dart';
import 'package:fashion_app/features/products/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryProductsScreen extends ConsumerStatefulWidget {
  final String categoryId;
  final Category category;

  const CategoryProductsScreen(
      {super.key, required this.categoryId, required this.category});

  @override
  ConsumerState<CategoryProductsScreen> createState() =>
      _CategoryProductsScreenState();
}

class _CategoryProductsScreenState
    extends ConsumerState<CategoryProductsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref
          .read(productCategoryProvider.notifier)
          .loadProductsbyCategory(widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productCategoryProvider);

    return ResponsiveScaffold(
        body: productState is ProductLoading
            ? const Center(
                child: AppLoadingIndicator(),
              )
            : productState is ProductError
                ? const Center(
                    child: Text("Failed to load products"),
                  )
                : productState is ProductLoaded
                    ? SingleChildScrollView(
                        child: Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const BackButton(),
                            //products
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              spacing: 4,
                              children: [
                                //category name and number of products in category
                                AppText(
                                  text: widget.category.name,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                AppText(
                                  text: '(${productState.products.length})',
                                  fontWeight: FontWeight.bold,
                                )
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: GridView.builder(
                                  itemCount: productState.products.length,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.7,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 8,
                                    crossAxisCount: 2,
                                  ),
                                  itemBuilder: (context, index) {
                                    final product =
                                        productState.products[index];
                                    return ProductCard(
                                      products: product,
                                    );
                                  }),
                            )
                          ],
                        ),
                      )
                    : const SizedBox());
  }
}
