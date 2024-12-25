import 'package:flutter/material.dart';

class CategoryImage extends StatelessWidget {
  final String image;
  final void Function()? onTap;
  const CategoryImage({super.key, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 60,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.secondary),
        child: Image.network(
          image,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(Icons.broken_image, color: Colors.red, size: 30),
            );
          },
        ),
      ),
    );
  }
}
