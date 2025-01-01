import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/core/constants/button.dart';
import 'package:fashion_app/core/responsive/responsve_scaffold.dart';
import 'package:fashion_app/features/authentication/presentation/widgets/textfield.dart';
import 'package:fashion_app/features/cart/presentation/screen/order_placed_screen.dart';
import 'package:fashion_app/features/cart/presentation/widgets/cart_details.dart';
import 'package:fashion_app/features/cart/presentation/widgets/checkout_tile.dart';
import 'package:fashion_app/features/products/presentation/widgets/product_button.dart';
import 'package:fashion_app/features/settings/presentation/provider/settings_provider.dart';
import 'package:fashion_app/features/settings/presentation/provider/settings_state.dart';
import 'package:fashion_app/features/settings/presentation/screens/display_address.dart';
import 'package:fashion_app/features/settings/presentation/screens/display_cards.dart';
import 'package:fashion_app/features/settings/presentation/widgets/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  final CartDetails cartDetails;

  const CheckoutScreen({super.key, required this.cartDetails});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String? selectedAddress;

//modal sheet for selecting adddress
  void _showAddressSelector(BuildContext context, List<String> addresses) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              return SettingsTile(
                title: addresses[index],
                trailingWidget: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(context, addresses[index]);
                },
              );
            },
          ),
        );
      },
    ).then((value) {
      if (value != null && value is String) {
        setState(() {
          selectedAddress = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(settingsProvider);

    // Fetch user addresses if settingsState is loaded
    final addresses = (settingsState is SettingsLoaded &&
            settingsState.user.address.isNotEmpty)
        ? settingsState.user.address
        : ["No addresses available. Please add one!"];

    // Initialize selectedAddress
    selectedAddress ??= addresses.isNotEmpty &&
            addresses[0] != "No addresses available. Please add one!"
        ? addresses[0]
        : null;

    return ResponsiveScaffold(
      appBar: AppBar(
        title: const Center(
          child: AppText(
            text: 'Checkout',
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          //address and payment information
          SizedBox(
            height: 150,
            child: ListView(
              shrinkWrap: true,
              children: [
                CheckoutTile(
                  title: 'Shipping Address',
                  subTitle: selectedAddress ?? "Add shipping address",
                  onTap: () {
                    _showAddressSelector(context, addresses);
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                CheckoutTile(
                  title: 'Payment Method',
                  subTitle: "Add Payment Method",
                  onTap: () {},
                ),
              ],
            ),
          ),
          const Spacer(),
          // cart details and button
          CartDetails(
              subtotal: widget.cartDetails.subtotal,
              total: widget.cartDetails.total),
          ProductButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OrderPlacedScreen(),
                ),
              );
            },
            text: widget.cartDetails.total.toString(),
            label: 'Place Order',
          )
        ],
      ),
    );
  }
}
