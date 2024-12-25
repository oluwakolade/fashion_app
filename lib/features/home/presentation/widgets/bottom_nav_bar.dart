import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class AppBottomBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.inversePrimary;
    final activeColor = Theme.of(context).colorScheme.tertiary;
    final background = Theme.of(context).colorScheme.surface;

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
            icon: const Icon(Icons.notifications_outlined),
          ),
          PersistentBottomNavBarItem(
              activeColorPrimary: activeColor,
              inactiveColorPrimary: color,
              icon: const Icon(Icons.list_alt_outlined)),
          PersistentBottomNavBarItem(
              activeColorPrimary: activeColor,
              inactiveColorPrimary: color,
              icon: const Icon(Icons.person_outline)),
        ]);
  }
}
