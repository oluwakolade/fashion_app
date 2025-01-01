import 'package:fashion_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';

class ProductButton extends StatelessWidget {
  final String text;
  final String label;
  final void Function()? onPressed;
  const ProductButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          side: BorderSide.none,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              text: '\$$text',
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            AppText(
              text: label,
              fontSize: 16,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductButtonCircle extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;
  const ProductButtonCircle(
      {super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          padding: const EdgeInsets.all(12),
          side: BorderSide.none,
          shape: const CircleBorder()),
      child: Center(
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
