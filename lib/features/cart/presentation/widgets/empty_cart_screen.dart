import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/core/constants/button.dart';
import 'package:flutter/material.dart';

class EmptyCartScreen extends StatelessWidget {
  final void Function()? onPressed;
  const EmptyCartScreen({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/empty_bag.png'),
          AppText(
            text: "Your Cart is Empty",
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20,
          ),
          AppButton(onPressed: onPressed, text: "Excplore Categories")
        ],
      ),
    );
  }
}
