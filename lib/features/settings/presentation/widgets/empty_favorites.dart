import 'package:fashion_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';

class EmptyFavorites extends StatelessWidget {
  const EmptyFavorites({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppText(
        text: "Your Favorites is Empty",
        color: Theme.of(context).colorScheme.primary,
        fontSize: 20,
      ),
    );
  }
}
