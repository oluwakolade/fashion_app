import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/core/responsive/responsve_scaffold.dart';
import 'package:fashion_app/features/cart/domain/entities/cart.dart';
import 'package:fashion_app/features/cart/presentation/provider/cart_provider.dart';
import 'package:fashion_app/features/products/domain/entities/products.dart';
import 'package:fashion_app/features/products/presentation/provider/product_provider.dart';
import 'package:fashion_app/features/products/presentation/provider/product_state.dart';
import 'package:fashion_app/features/products/presentation/widgets/product_button.dart';
import 'package:fashion_app/features/products/presentation/widgets/product_dropdown.dart';
import 'package:fashion_app/features/products/presentation/widgets/select_product_color.dart';
import 'package:fashion_app/features/products/presentation/widgets/select_products_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetails extends ConsumerStatefulWidget {
  final Products products;
  const ProductDetails({super.key, required this.products});

  @override
  ConsumerState<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ConsumerState<ProductDetails> {
  int quantity = 1;
  String size = 'S';
  Color color = Colors.black;

  void updateQuantity(bool increase) {
    setState(() {
      quantity = increase ? quantity + 1 : (quantity > 1 ? quantity - 1 : 1);
    });
    ref
        .read(productProvider.notifier)
        .getTotal(widget.products.price, quantity);
  }

  void changeSize(String newSize) {
    setState(() {
      size = newSize;
    });
  }

  void changeColor(Color newColor) {
    setState(() {
      color = newColor;
    });
  }

  void addToCart() {
    final cartItem = CartItem(
        product: widget.products,
        size: size,
        color: color,
        quantity: quantity,
        total: widget.products.price * quantity);

    ref.read(cartProvider.notifier).addToCart(cartItem);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.products.name} added to cart!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productProvider);
    final theme = Theme.of(context).colorScheme;

    return ResponsiveScaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const BackButton(),
                    InkWell(
                      onTap: () {
                        ref
                            .read(productProvider.notifier)
                            .toggleLikes(widget.products.id);
                      },
                      child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: theme.secondary, shape: BoxShape.circle),
                          child: Icon(
                              widget.products.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: widget.products.isFavorite
                                  ? Colors.red
                                  : Colors.black)),
                    )
                  ],
                ),
                //images slide show
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Image.network(
                          widget.products.images![index],
                          // height: 120,
                          // width: 80,
                          fit: BoxFit.cover,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                            width: 10,
                          ),
                      itemCount: widget.products.images!.length),
                ),

                //product name
                AppText(
                  text: widget.products.name,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                AppText(
                  text: '\$${widget.products.price.toStringAsFixed(2)}',
                  fontSize: 15,
                  color: theme.tertiary,
                  fontWeight: FontWeight.bold,
                ),
                //size
                ProductDropdown(
                  onPressed: () {
                    openSizePicker(
                        context: context,
                        onSizeSelected: changeSize,
                        selectedSize: size,
                        isSelected: true);
                  },
                  text: "Size",
                  leadingWidget: AppText(
                    text: size,
                    fontWeight: FontWeight.bold,
                  ),
                  icon: Icons.arrow_drop_down,
                ),
                //color
                ProductDropdown(
                  onPressed: () {
                    openColorPicker(
                        context: context,
                        onColorSelected: changeColor,
                        selectedColor: color,
                        isSelected: true);
                  },
                  text: "Color",
                  leadingWidget: Container(
                    width: 10,
                    height: 10,
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: color),
                  ),
                  icon: Icons.arrow_drop_down,
                ),

                //quantity
                ProductQuantityBtn(
                  text: "Quantity",
                  button1: ProductButtonCircle(
                      onPressed: () => updateQuantity(true), icon: Icons.add),
                  label: quantity.toString(),
                  button2: ProductButtonCircle(
                      onPressed: () => updateQuantity(false),
                      icon: Icons.remove),
                ),

                //description
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: SingleChildScrollView(
                    child: AppText(
                      text: widget.products.description,
                      color: theme.secondary,
                      fontSize: 12,
                    ),
                  ),
                ),

                const AppText(
                  text: 'Shipping and Returns',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                AppText(
                  text: 'Free standard shipping and free 60-day returns',
                  color: theme.secondary,
                  fontSize: 12,
                ),
                const AppText(
                  text: 'Reviews',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                AppText(
                  text: '${widget.products.ratings.toStringAsFixed(1)} Ratings',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                AppText(
                  text: '${widget.products.review} Reviews',
                  color: theme.secondary,
                  fontSize: 12,
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: ProductButton(
                onPressed: addToCart,
                text: (productState is ProductLoaded &&
                        productState.total != null)
                    ? productState.total!.toStringAsFixed(2)
                    : widget.products.price.toStringAsFixed(2)),
          ),

          //button
        ],
      ),
    );
  }
}