import 'package:flutter/material.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.tertiary,
          backgroundColor: Colors.transparent,
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}
