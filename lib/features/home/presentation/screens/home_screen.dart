import 'package:fashion_app/core/responsive/responsve_scaffold.dart';
import 'package:fashion_app/features/cart/presentation/screen/cart_screen.dart';
import 'package:fashion_app/features/home/presentation/screens/products_screen.dart';
import 'package:fashion_app/features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:fashion_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PersistentTabController controller =
      PersistentTabController(initialIndex: 0);

//on page change
  void onPageChange(int index) {
    setState(() {
      controller.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const ProductsScreen(),
      const CartScreen(),
      const SettingsScreen()
    ];
    return ResponsiveScaffold(
      body: AppBottomBar(
          onTap: (value) => onPageChange(value),
          screens: screens,
          controller: controller),
    );
  }
}
