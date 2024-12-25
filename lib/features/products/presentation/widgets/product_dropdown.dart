import 'package:fashion_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';

class ProductDropdown extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Widget leadingWidget;
  final IconData icon;

  const ProductDropdown({
    super.key,
    this.onPressed,
    required this.text,
    required this.leadingWidget,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          side: BorderSide.none,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              text: text,
              fontSize: 14,
              color: Theme.of(context).colorScheme.primary,
            ),
            Row(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leadingWidget,
                Icon(icon),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProductQuantityBtn extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Widget button1;
  final Widget button2;

  final String label;

  const ProductQuantityBtn({
    super.key,
    this.onPressed,
    required this.text,
    required this.label,
    required this.button1,
    required this.button2,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          side: BorderSide.none,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              text: text,
              fontSize: 14,
              color: Theme.of(context).colorScheme.primary,
            ),
            Row(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                button1,
                AppText(
                  text: label,
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.primary,
                ),
                button2,
              ],
            )
          ],
        ),
      ),
    );
  }
}
