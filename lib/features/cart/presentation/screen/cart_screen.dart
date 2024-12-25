import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/core/constants/button.dart';
import 'package:fashion_app/core/responsive/responsve_scaffold.dart';
import 'package:fashion_app/features/cart/presentation/provider/cart_provider.dart';
import 'package:fashion_app/features/cart/presentation/provider/cart_state.dart';
import 'package:fashion_app/features/cart/presentation/widgets/cart_details.dart';
import 'package:fashion_app/features/cart/presentation/widgets/cart_tile.dart';
import 'package:fashion_app/features/cart/presentation/widgets/empty_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    final theme = Theme.of(context).colorScheme;
    return ResponsiveScaffold(
      appBar: AppBar(
        title: AppText(
          text: 'Cart',
          color: theme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: (cartState is CartEmpty)
            ? EmptyCartScreen(onPressed: () {})
            : (cartState is CartError)
                ? const Center(
                    child: Text(
                      'Error',
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : (cartState is CartLoaded)
                    ? Column(
                        spacing: 10,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
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
                          ListView.separated(
                            itemCount: cartState.cart.length,
                            itemBuilder: (context, index) {
                              final cartItem = cartState.cart[index];
                              return CartTile(
                                image: cartItem.product.image,
                                title: cartItem.product.name,
                                size: cartItem.size,
                                color: cartItem.color,
                                colorName: cartItem.color.toString(),
                                price: cartItem.product.price,
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

                          //cart details
                          CartDetails(
                              subtotal: cartState.total,
                              total: cartState.total + 8.0),

                          //cart button

                          AppButton(onPressed: () {}, text: "Checkout")
                        ],
                      )
                    : const SizedBox(),
      ),
    );
  }
}
