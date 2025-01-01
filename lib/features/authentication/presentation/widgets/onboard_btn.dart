import 'package:fashion_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';

class OnboardButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function(String) onSelected;
  const OnboardButton(
      {super.key,
      required this.label,
      required this.isSelected,
      required this.onSelected});

  // bool isPress = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected(label),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isSelected
              ? Theme.of(context).colorScheme.tertiary
              : Theme.of(context).colorScheme.secondary,
        ),
        child: Center(
          child: AppText(
              text: label, color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
