import 'package:fashion_app/core/responsive/responsve_scaffold.dart';
import 'package:fashion_app/features/home/presentation/widgets/category_view.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //header
          Row(
            children: [],
          ),
          //search bar

          //categories
          CategoryView()

          //top selling

          //new in
        ],
      ),
    );
  }
}
