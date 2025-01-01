import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/features/products/presentation/widgets/product_button.dart';
import 'package:flutter/material.dart';

class CartDetails extends StatelessWidget {
  final double subtotal;

  final double total;
  const CartDetails({super.key, required this.subtotal, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // spacing: 4,
        children: [
          //subtotal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: 'Subtotal',
                fontSize: 12,
                color: Theme.of(context).colorScheme.secondary,
              ),
              AppText(
                text: '\$${subtotal.toStringAsFixed(2)}',
                fontSize: 12,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
          //shipping
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: 'Shpping Cost',
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 12,
              ),
              AppText(
                text: '\$8.00',
                color: Theme.of(context).colorScheme.primary,
                fontSize: 12,
              ),
            ],
          ),
          //taxc
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: 'Tax ',
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 12,
              ),
              AppText(
                text: '\$0.00',
                color: Theme.of(context).colorScheme.primary,
                fontSize: 12,
              ),
            ],
          ),

          //totla
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: 'Total',
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 12,
              ),
              AppText(
                text: '\$${total.toStringAsFixed(2)}',
                color: Theme.of(context).colorScheme.primary,
                fontSize: 12,
              ),
            ],
          ),

          const CartInput()
        ],
      ),
    );
  }
}

class CartInput extends StatelessWidget {
  const CartInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: Colors.green),
            ),
            child: const Icon(
              Icons.close_outlined,
              color: Colors.green,
              size: 15,
            ),
          ),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.tertiary),
            child: const Center(
              child: Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ),
        fillColor: Theme.of(context).colorScheme.secondary,
        filled: true,
        hintText: 'Enter Coupon Code',
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide.none),
      ),
    );
  }
}
