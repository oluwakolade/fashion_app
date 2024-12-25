import 'package:fashion_app/core/responsive/responsve_scaffold.dart';
import 'package:fashion_app/features/category/presentation/widgets/category_view.dart';
import 'package:fashion_app/features/featured_category/presentaion/widgets/featured_products.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveScaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //header
            // Row(
            //   children: [],
            // ),
            //search bar
            //categories
            CategoryView(),
            //top selling
            FeaturedProducts(
              featureName: 'New In',
            ),

            //new in
          ],
        ),
      ),
    );
  }
}
