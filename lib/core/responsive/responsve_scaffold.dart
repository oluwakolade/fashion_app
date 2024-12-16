//normal scafold bt with a contrsined width

import 'package:flutter/material.dart';

class ResponsiveScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? bottomNavBar;
  const ResponsiveScaffold(
      {super.key,
      required this.body,
      this.appBar,
      this.drawer,
      this.bottomNavBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      bottomNavigationBar: bottomNavBar,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 430.00,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: body,
          ),
        ),
      ),
    );
  }
}
