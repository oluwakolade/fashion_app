import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBottomBar extends StatelessWidget {
  final int index;
  final ValueChanged onTap;
  const AppBottomBar({super.key, required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondary;
    final activeColor = Theme.of(context).colorScheme.tertiary;
    final background = Theme.of(context).colorScheme.surface;

    return Container(
      padding: const EdgeInsets.all(15),
      child: BottomNavigationBar(
          currentIndex: index,
          onTap: onTap,
          selectedItemColor: activeColor,
          unselectedItemColor: color,
          backgroundColor: background,
          items: const [
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house)),
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.bell)),
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.list)),
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.person)),
          ]),
    );
  }
}
