import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/core/responsive/responsve_scaffold.dart';
import 'package:fashion_app/features/category/domain/entities/category.dart';
import 'package:fashion_app/features/category/presentation/screens/category_products_screen.dart.dart';
import 'package:fashion_app/features/category/presentation/widgets/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShopByCategoriesScreen extends ConsumerWidget {
  final List<Category> category;
  const ShopByCategoriesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final categoryState = ref.watch(categoryProvider);
    return ResponsiveScaffold(
      body: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BackButton(),
          const AppText(
            text: "Shop by Categories",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: category.length,
              itemBuilder: (context, index) {
                final categories = category[index];

                return CategoryTile(
                    image: categories.image,
                    name: categories.name,
                    onTap: () {
                      // Navigate to products screen for this category
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryProductsScreen(
                            categoryId: categories.id,
                            category: categories,
                          ),
                        ),
                      );
                    });
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
