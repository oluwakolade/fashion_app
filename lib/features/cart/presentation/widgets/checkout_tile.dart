import 'package:fashion_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';

class CheckoutTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final void Function()? onTap;
  const CheckoutTile(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: AppText(
        text: title,
        color: Theme.of(context).colorScheme.inversePrimary,
        fontSize: 12,
      ),
      subtitle: AppText(
        text: subTitle,
        color: Theme.of(context).colorScheme.primary,
        fontSize: 14,
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
