import 'package:fashion_app/core/responsive/responsve_scaffold.dart';
import 'package:fashion_app/features/home/presentation/screens/products_screen.dart';
import 'package:fashion_app/features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PersistentTabController controller =
      PersistentTabController(initialIndex: 0);

  final List<Widget> screens = [
    const ProductsScreen(),
    const Page2(),
    const Page3(),
    const Page4(),
  ];
//on page change
  void onPageChange(int index) {
    setState(() {
      controller.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      body: AppBottomBar(
          onTap: (value) => onPageChange(value),
          screens: screens,
          controller: controller),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.pink,
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
    );
  }
}
