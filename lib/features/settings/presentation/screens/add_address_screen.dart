import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/core/constants/button.dart';
import 'package:fashion_app/core/responsive/responsve_scaffold.dart';
import 'package:fashion_app/features/authentication/presentation/widgets/textfield.dart';
import 'package:fashion_app/features/settings/domain/entities/user.dart';
import 'package:fashion_app/features/settings/presentation/provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddAddressScreen extends ConsumerStatefulWidget {
  final User user;
  final int? addressIndex;
  const AddAddressScreen({super.key, required this.user, this.addressIndex});

  @override
  ConsumerState<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends ConsumerState<AddAddressScreen> {
  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();
  final cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill the text field if editing an address
    if (widget.addressIndex != null) {
      addressController.text = widget.user.address[widget.addressIndex!];
    }
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  void updateAddress() {
    final address = addressController.text.trim();

    if (address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid address")),
      );
      return;
    }

    final notifier = ref.read(settingsProvider.notifier);
    final updatedAddresses = List<String>.from(widget.user.address);

    if (widget.addressIndex != null) {
      // Edit existing address
      updatedAddresses[widget.addressIndex!] = address;
    } else {
      // Add new address
      updatedAddresses.add(address);
    }

    notifier.updateUserProfile(
      uid: widget.user.uid,
      newAddress: updatedAddresses,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Center(
          child: AppText(
            text: "Add Address",
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            spacing: 10,
            children: [
              AppTextfield(
                  controller: addressController,
                  hintText: "Address",
                  obsecureText: false),
              AppTextfield(
                  controller: cityController,
                  hintText: "City",
                  obsecureText: false),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: AppTextfield(
                        controller: stateController,
                        hintText: "State",
                        obsecureText: false),
                  ),
                  Expanded(
                    child: AppTextfield(
                        controller: zipController,
                        hintText: "Zip Code",
                        obsecureText: false),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(child: AppButton(onPressed: updateAddress, text: "Save"))
            ],
          ),
        ),
      ),
    );
  }
}
