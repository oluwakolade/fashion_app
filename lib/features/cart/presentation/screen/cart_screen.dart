import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/core/constants/button.dart';
import 'package:fashion_app/core/responsive/responsve_scaffold.dart';
import 'package:fashion_app/features/cart/presentation/provider/cart_provider.dart';
import 'package:fashion_app/features/cart/presentation/provider/cart_state.dart';
import 'package:fashion_app/features/cart/presentation/screen/checkout_screen.dart';
import 'package:fashion_app/features/cart/presentation/widgets/cart_details.dart';
import 'package:fashion_app/features/cart/presentation/widgets/cart_tile.dart';
import 'package:fashion_app/features/cart/presentation/widgets/empty_cart_screen.dart';
import 'package:fashion_app/features/category/presentation/provider/category_provider.dart';
import 'package:fashion_app/features/category/presentation/provider/category_state.dart';
import 'package:fashion_app/features/category/presentation/screens/shop_by_categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);
    final category = ref.watch(categoryProvider);

    final theme = Theme.of(context).colorScheme;
    return ResponsiveScaffold(
      appBar: AppBar(
        title: Center(
          child: AppText(
            text: 'Cart',
            color: theme.primary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: (cartState is CartEmpty)
          ? Center(
              child: EmptyCartScreen(
                onPressed: () {
                  if (category is CategoryLoaded) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ShopByCategoriesScreen(category: category.category),
                      ),
                    );
                  }
                },
              ),
            )
          : (cartState is CartError)
              ? const Center(
                  child: Text(
                    'Error',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : (cartState is CartLoaded)
                  ? Stack(children: [
                      Column(
                        spacing: 10,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  ref.read(cartProvider.notifier).clearCart();
                                },
                                child: AppText(
                                  text: 'Remove All',
                                  color: theme.primary,
                                ),
                              ),
                            ],
                          ),

                          //cart tile list view
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: cartState.cart.length,
                              itemBuilder: (context, index) {
                                final cartItem = cartState.cart[index];
                                return CartTile(
                                  image: cartItem.product.image,
                                  title: cartItem.product.name,
                                  size: cartItem.size,
                                  color: cartItem.color,
                                  colorName: cartItem.color.toString(),
                                  price: cartItem.product.price *
                                      cartItem.quantity,
                                  cartQuantity: cartItem.quantity,
                                  onRemove: () {
                                    ref
                                        .read(cartProvider.notifier)
                                        .removeFromCart(cartItem);
                                  },
                                  onUpdateQuantity: (newQuantity) {
                                    ref
                                        .read(cartProvider.notifier)
                                        .updateQuantity(cartItem, newQuantity);
                                  },
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(
                                height: 5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        // cart details
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CartDetails(
                                subtotal: cartState.total,
                                total: cartState.total + 8.0),
                            AppButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CheckoutScreen(
                                        cartDetails: CartDetails(
                                            subtotal: cartState.total,
                                            total: cartState.total + 8.0),
                                      ),
                                    ),
                                  );
                                },
                                text: "Checkout")
                          ],
                        ),
                      ),
                      //cart button
                    ])
                  : const SizedBox(),
    );
  }
}
