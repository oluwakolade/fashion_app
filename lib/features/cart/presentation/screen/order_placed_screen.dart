import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/core/constants/button.dart';
import 'package:fashion_app/core/responsive/responsve_scaffold.dart';
import 'package:flutter/material.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            color: Theme.of(context).colorScheme.tertiary,
            child: Center(
              child: Image.asset(
                'assets/checkout.png',
                height: 250,
                width: 250,
              ),
            ),
          ),
          Expanded(
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.4,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(10),
                  left: Radius.circular(10),
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: [
                  AppText(
                    text: "Order Placed \n Successfully",
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  AppText(
                    text: "You will recive an email confirmation",
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 14,
                  ),
                  const Spacer(),
                  AppButton(
                    onPressed: () {},
                    text: 'See order details',
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
