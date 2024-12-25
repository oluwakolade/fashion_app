import 'package:fashion_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String image;
  final String name;
  final void Function()? onTap;

  const CategoryTile(
      {super.key,
      required this.image,
      required this.name,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: Theme.of(context).colorScheme.secondary,
      leading: Container(
        height: 30,
        width: 30,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.secondary),
        child: Image.network(
          image,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(Icons.broken_image, color: Colors.red, size: 20),
            );
          },
        ),
      ),
      title: AppText(text: name),
    );
  }
}
