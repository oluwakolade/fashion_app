import 'package:fashion_app/core/responsive/responsve_scaffold.dart';
import 'package:fashion_app/features/category/presentation/widgets/category_view.dart';
import 'package:fashion_app/features/featured_category/presentaion/widgets/featured_products.dart';
import 'package:fashion_app/features/home/presentation/widgets/search_bar.dart';
import 'package:fashion_app/features/products/presentation/widgets/all_products_grid.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key, required});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //header
            Row(
              spacing: 5,
              children: [
                //profile photo
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  radius: 25,
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),

                const Expanded(child: AppSearchBar()),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            //search bar
            //categories
            const CategoryView(),
            //top selling
            const FeaturedProducts(
              featureName: 'Popular',
            ),
            const AllProductsGrid()

            //new in
          ],
        ),
      ),
    );
  }
}
