import 'package:fashion_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final Widget? subtitle;
  final Widget trailingWidget;
  final Widget? leadingWidget;
  final void Function()? onTap;

  const SettingsTile(
      {super.key,
      required this.title,
      this.leadingWidget,
      this.subtitle,
      required this.trailingWidget,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: Theme.of(context).colorScheme.secondary,
      leading: leadingWidget,
      title: AppText(text: title),
      subtitle: subtitle,
      trailing: trailingWidget,
    );
  }
}
