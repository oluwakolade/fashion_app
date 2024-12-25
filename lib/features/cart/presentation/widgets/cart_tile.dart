import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/features/products/presentation/widgets/product_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  const CartTile(
      {super.key,
      required this.image,
      required this.colorName,
      required this.title,
      required this.size,
      required this.color,
      required this.price,
      // required this.onAdd,
      required this.cartQuantity,
      required this.onUpdateQuantity,
      // required this.onDelete,
      required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.secondary,
      contentPadding: const EdgeInsets.all(15),
      leading: Container(
        height: 40,
        width: 40,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.secondary),
        child: Image.network(
          image,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(Icons.broken_image, color: Colors.red, size: 20),
            );
          },
        ),
      ),
      title: AppText(
        text: title,
        color: Theme.of(context).colorScheme.primary,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      subtitle: Row(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DefaultTextStyle(
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: RichText(
              text: TextSpan(
                text: "Size",
                children: [
                  TextSpan(
                    text: size,
                    style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          DefaultTextStyle(
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: RichText(
              text: TextSpan(
                text: "Color",
                children: [
                  TextSpan(
                    text: colorName,
                    style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: color,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      trailing: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () => onUpdateQuantity(cartQuantity - 1),
              icon: const Icon(Icons.close)),
          AppText(
            text: '\$${price.toStringAsFixed(2)} X$cartQuantity',
            color: Theme.of(context).colorScheme.primary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          Row(
            spacing: 4,
            children: [
              ProductButtonCircle(
                  onPressed: () => onUpdateQuantity(cartQuantity + 1),
                  icon: Icons.add),
              ProductButtonCircle(onPressed: onRemove, icon: Icons.add)
            ],
          )
        ],
      ),
    );
  }
}
