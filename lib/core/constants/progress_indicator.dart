import 'package:flutter/material.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.tertiary,
          backgroundColor: Colors.transparent,
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}
