import 'package:fashion_app/features/cart/domain/entities/cart.dart';
import 'package:fashion_app/features/cart/presentation/provider/cart_state.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(CartEmpty());
  final List<CartItem> _cart = [];

  List<CartItem> get cart => List.unmodifiable(_cart);

  double _calculateTotal() {
    return _cart.fold(0, (sum, item) => sum + item.total);
  }

//ADD TO CART
  void addToCart(CartItem item) {
    try {
      // Check if the item already exists in the cart
      final existingIndex = _cart.indexWhere(
        (cartItem) =>
            cartItem.product.id == item.product.id &&
            cartItem.size == item.size &&
            cartItem.color == item.color,
      );

      if (existingIndex != -1) {
        // If the item exists, update its quantity
        final existingItem = _cart[existingIndex];
        _cart[existingIndex] = existingItem.copyWith(
          quantity: existingItem.quantity + item.quantity,
        );
      } else {
        // Add as a new item
        _cart.add(item);
      }

      state = CartLoaded(cart: cart, total: _calculateTotal());
    } catch (e) {
      state = CartError('Failed to add item to cart: $e');
    }
  }

  //REMOVE FROM CART

  void removeFromCart(CartItem item) {
    try {
      _cart.remove(item);
      state = _cart.isEmpty
          ? CartEmpty()
          : CartLoaded(cart: cart, total: _calculateTotal());
    } catch (e) {
      state = CartError('Failed to remove item from cart: $e');
    }
  }

//UPDATE QUNATITY
  void updateQuantity(CartItem item, int quantity) {
    try {
      if (quantity < 1) {
        removeFromCart(item);
        return;
      }

      final index = _cart.indexWhere(
        (cartItem) =>
            cartItem.product.id == item.product.id &&
            cartItem.size == item.size &&
            cartItem.color == item.color,
      );

      if (index != -1) {
        _cart[index] = _cart[index].copyWith(quantity: quantity);
        state = CartLoaded(cart: cart, total: _calculateTotal());
      }
    } catch (e) {
      state = CartError('Failed to update quantity: $e');
    }
  }

//CLEAR CART
  void clearCart() {
    _cart.clear();
    state = CartEmpty();
  }
}




















// List to hold products in the cart
//   final List<Products> cart = [];
//   final Map<Products, int> productQuantities = {};

//   double _calculateTotal() {
//     return cart.fold(
//       0,
//       (sum, product) => sum + (product.price * productQuantities[product]!),
//     );
//   }

//   void addToCart(Products product) {
//     try {
//       if (!cart.contains(product)) {
//         cart.add(product);
//         productQuantities[product] = 1; // Initialize quantity for new product
//       } else {
//         productQuantities[product] = productQuantities[product]! + 1;
//       }

//       state = CartLoaded(
//         products: List.unmodifiable(cart),
//         total: _calculateTotal(),
//       );
//     } catch (e) {
//       state = CartError('Failed to add product to cart: $e');
//     }
//   }

//   void removeFromCart(Products product) {
//     try {
//       if (cart.contains(product)) {
//         if (productQuantities[product]! > 1) {
//           productQuantities[product] = productQuantities[product]! - 1;
//         } else {
//           cart.remove(product);
//           productQuantities.remove(product);
//         }

//         if (cart.isEmpty) {
//           state = CartEmpty();
//         } else {
//           state = CartLoaded(
//             products: List.unmodifiable(cart),
//             total: _calculateTotal(),
//           );
//         }
//       }
//     } catch (e) {
//       state = CartError('Failed to remove product from cart: $e');
//     }
//   }

//   void updateQuantity(Products product, int newQuantity) {
//     try {
//       if (newQuantity < 1) {
//         removeFromCart(product);
//       } else if (cart.contains(product)) {
//         productQuantities[product] = newQuantity;
//         state = CartLoaded(
//           products: List.unmodifiable(cart),
//           total: _calculateTotal(),
//         );
//       }
//     } catch (e) {
//       state = CartError('Failed to update quantity: $e');
//     }
//   }

//   void clearCart() {
//     try {
//       cart.clear();
//       productQuantities.clear();
//       state = CartEmpty();
//     } catch (e) {
//       state = CartError('Failed to clear the cart: $e');
//     }
//   }
// }















// class CartNotifier extends StateNotifier<CartState> {
//   CartNotifier() : super(CartEmpty());

//   // Initialize with an empty list of products
//   final List<Products> cart = [];

//   Products? product;
//   int quantity = 0;
//   double total = 0;

//   void addToCart(Products product) {
//     try {
//       if (state is CartEmpty) {
//         product = product;
//         quantity = 1;
//         total = product.price;
//         state = CartLoaded(product: product, quantity: quantity, total: total);
//       } else if (state is CartLoaded) {
//         quantity++;
//         total += product.price;
//         state = CartLoaded(product: product, quantity: quantity, total: total);
//       }
//     } catch (e) {
//       state = CartError('Failed to add product to cart: $e');
//     }
//   }

//   void removeFromCart(Products product) {
//     try {
//       if (state is CartLoaded && product.id == product.id) {
//         if (quantity > 1) {
//           quantity--;
//           total -= product.price;
//           state =
//               CartLoaded(product: product, quantity: quantity, total: total);
//         } else {
//           clearCart();
//         }
//       }
//     } catch (e) {
//       state = CartError('Failed to remove product from cart: $e');
//     }
//   }

//   void updateQuantity(int newQuantity) {
//     try {
//       if (state is CartLoaded && newQuantity > 0) {
//         quantity = newQuantity;
//         total = product!.price * quantity;
//         state = CartLoaded(product: product!, quantity: quantity, total: total);
//       } else if (newQuantity <= 0) {
//         clearCart();
//       }
//     } catch (e) {
//       state = CartError('Failed to update quantity: $e');
//     }
//   }

//   void clearCart() {
//     try {
//       product = null;
//       quantity = 0;
//       total = 0;
//       state = CartEmpty();
//     } catch (e) {
//       state = CartError('Failed to clear cart: $e');
//     }
//   }
// }










  // void addToCart(Products product) {
  //   try {
  //     // Add the product to the cart
  //     cart.add(product);

  //     state = CartLoaded(products: List.unmodifiable(cart));
  //   } catch (e) {
  //     state = CartError('Failed to add product to cart: $e');
  //   }
  // }

  // void removeFromCart(Products product) {
  //   try {
  //     // Remove the product from the cart
  //     cart.remove(product);

  //     // Update the state based on the new cart content
  //     if (cart.isEmpty) {
  //       state = CartEmpty();
  //     } else {
  //       state = CartLoaded(products: List.unmodifiable(cart));
  //     }
  //   } catch (e) {
  //     state = CartError('Failed to remove product from cart: $e');
  //   }
  // }

  // void clearCart(Products product) {
  //   try {
  //     if (cart.isNotEmpty) {
  //       cart.clear();
  //       state = CartEmpty();
  //     }
  //   } catch (e) {
  //     state = CartError('Failed to clear  cart: $e');
  //   }
  // }

  // void updateQuantity(Products product, int newQuantity) {
  //   if (newQuantity < 1) {
  //     removeFromCart(product);
  //     return;
  //   }

  //   try {
  //     state = CartEmpty();
       
  //         final updatedItems = [...product];
  //         final existingItemIndex =
  //             updatedItems.indexWhere((product) => product.product.id == product.id);

  //         if (existingItemIndex != -1) {
  //           // Update the quantity of the product
  //           updatedItems[existingItemIndex] =
  //               updatedItems[existingItemIndex].copyWith(
  //             quantity: newQuantity,
  //           );

  //           state = CartLoaded(
  //             items: updatedItems,
  //             total: _calculateTotal(updatedItems),
  //           );
          
        
  //       orElse: () {},
      
  //   } catch (e) {
  //     state = CartError('Failed to update quantity: $e');
  //   }
  // }

  // // Calculate the total cost of the cart
  // double calculateTotal(Products products) {
  //   double total = 0;
  //   return for (products in )
  // }