import 'package:fashion_app/features/cart/presentation/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class AppBottomBar extends ConsumerWidget {
  // final int index;
  final List<Widget> screens;
  final PersistentTabController controller;
  final void Function(int) onTap;
  const AppBottomBar(
      {super.key,
      required this.onTap,
      required this.screens,
      required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme.inversePrimary;
    final activeColor = Theme.of(context).colorScheme.tertiary;
    final background = Theme.of(context).colorScheme.surface;
    final cartState = ref.watch(cartProvider.notifier).cart.length;

    return PersistentTabView(context,
        controller: controller,
        screens: screens,
        onItemSelected: onTap,
        backgroundColor: background,
        navBarStyle: NavBarStyle.style6,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        items: [
          PersistentBottomNavBarItem(
              activeColorPrimary: activeColor,
              inactiveColorPrimary: color,
              icon: const Icon(Icons.home_outlined)),
          PersistentBottomNavBarItem(
            activeColorPrimary: activeColor,
            inactiveColorPrimary: color,
            icon: Stack(children: [
              const Icon(Icons.shopping_bag_outlined),
              (cartState != 0)
                  ? Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 15,
                        height: 15,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        child: Text(
                          cartState.toString(),

                          // numberOfItemsInCart.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                        ),
                      ),
                    )
                  : const SizedBox()
            ]),
          ),
          PersistentBottomNavBarItem(
              activeColorPrimary: activeColor,
              inactiveColorPrimary: color,
              icon: const Icon(Icons.person_outline)),
        ]);
  }
}
