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
      padding: EdgeInsets.zero,
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //subtotal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: 'Subtotal',
                color: Theme.of(context).colorScheme.secondary,
              ),
              AppText(
                text: '\$${subtotal.toStringAsFixed(2)}',
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
              ),
              AppText(
                text: '\$8.00',
                color: Theme.of(context).colorScheme.primary,
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
              ),
              AppText(
                text: '\$0.00',
                color: Theme.of(context).colorScheme.primary,
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
              ),
              AppText(
                text: '\$${total.toStringAsFixed(2)}',
                color: Theme.of(context).colorScheme.primary,
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
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextField(
        decoration: InputDecoration(
          prefix: Container(
            height: 10,
            width: 10,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.green),
            child: const Icon(
              Icons.close_outlined,
              color: Colors.green,
            ),
          ),
          suffix:
              ProductButtonCircle(onPressed: () {}, icon: Icons.chevron_right),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: 'Enter Coupon Code',
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
