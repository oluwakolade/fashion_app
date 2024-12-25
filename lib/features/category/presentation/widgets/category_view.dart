import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/core/constants/progress_indicator.dart';
import 'package:fashion_app/features/category/presentation/provider/category_provider.dart';
import 'package:fashion_app/features/category/presentation/provider/category_state.dart';
import 'package:fashion_app/features/category/presentation/screens/category_products_screen.dart.dart';
import 'package:fashion_app/features/category/presentation/screens/shop_by_categories_screen.dart';
import 'package:fashion_app/features/category/presentation/widgets/category_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryView extends ConsumerStatefulWidget {
  const CategoryView({super.key});

  @override
  ConsumerState<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends ConsumerState<CategoryView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(categoryProvider.notifier).loadAllCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryProvider);

    return SizedBox(
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                text: "Categories",
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              TextButton(
                onPressed: () {
                  if (categoryState is CategoryLoaded) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ShopByCategoriesScreen(
                          category:
                              categoryState.category, // Pass the entire list
                        ),
                      ),
                    );
                  }
                },
                child: AppText(
                  text: "See All",
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              )
            ],
          ),
          categoryState is CategoryLoading
              ? const AppLoadingIndicator()
              : categoryState is CategoryLoaded
                  ? Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryState.category.length,
                        itemBuilder: (context, index) {
                          final category = categoryState.category[index];

                          return Column(
                            spacing: 5.0,
                            children: [
                              CategoryImage(
                                image: category.image,
                                onTap: () {
                                  // Navigate to products screen for this category
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CategoryProductsScreen(
                                        categoryId: category.id,
                                        category: category,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              AppText(
                                text: category.name,
                              )
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          width: 10,
                        ),
                      ),
                    )
                  : categoryState is CategoryError
                      ? Center(
                          child: AppText(text: categoryState.message),
                        )
                      : const SizedBox(),
        ],
      ),
    );
  }
}
