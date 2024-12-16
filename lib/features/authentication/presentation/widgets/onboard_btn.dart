import 'package:fashion_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';

class OnboardButton extends StatefulWidget {
  final String label;
  const OnboardButton({super.key, required this.label});

  @override
  State<OnboardButton> createState() => _OnboardButtonState();
}

class _OnboardButtonState extends State<OnboardButton> {
  bool isPress = false;

  void update() {
    setState(() {
      isPress = !isPress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: update,
      child: Flexible(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: isPress
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.tertiary,
          ),
          child: Center(
            child: AppText(
                text: widget.label,
                color: isPress ? Colors.black : Colors.white),
          ),
        ),
      ),
    );
  }
}
