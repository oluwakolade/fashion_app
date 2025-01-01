import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/features/products/presentation/widgets/product_button.dart';
import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {
  final String image;
  final String title;
  final String size;
  final String colorName;
  final Color color;
  final double price;
  final int cartQuantity;
  final void Function()? onRemove;
  final void Function(int) onUpdateQuantity;

  const CartTile({
    super.key,
    required this.image,
    required this.colorName,
    required this.title,
    required this.size,
    required this.color,
    required this.price,
    required this.cartQuantity,
    required this.onUpdateQuantity,
    required this.onRemove,
  });

  static Map<Color, String> colorNameMap = {
    Colors.red: 'Red',
    Colors.blue: 'Blue',
    Colors.green: 'Green',
    Colors.white: 'White',
    Colors.black: 'Black',
  };
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 12,
        children: [
          // Product Image
          Container(
            width: 50,
            height: 50,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: theme.inversePrimary,
            ),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.image,
                color: Colors.red,
              ),
            ),
          ),
          // Product Details
          Expanded(
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: title,
                  color: theme.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                AppText(
                  text:
                      'Size: $size • Color: ${colorNameMap[color] ?? 'Default'}',
                  color: theme.inversePrimary,
                  fontSize: 10,
                ),
              ],
            ),
          ),
          // Quantity Controls
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 4,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: AppText(
                  text: '\$${price.toStringAsFixed(2)} X$cartQuantity',
                  fontSize: 12,
                  color: theme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                spacing: 0,
                children: [
                  ProductButtonCircle(
                    onPressed: () => onUpdateQuantity(cartQuantity - 1),
                    icon: Icons.remove,
                  ),
                  // AppText(
                  //   text: '$cartQuantity',
                  //   fontSize: 12,
                  //   color: theme.primary,
                  // ),
                  ProductButtonCircle(
                    onPressed: () => onUpdateQuantity(cartQuantity + 1),
                    icon: Icons.add,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
