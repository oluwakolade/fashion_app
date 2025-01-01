import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/core/constants/button.dart';
import 'package:fashion_app/core/responsive/responsve_scaffold.dart';
import 'package:fashion_app/features/authentication/presentation/widgets/textfield.dart';
import 'package:fashion_app/features/settings/domain/entities/user.dart';
import 'package:fashion_app/features/settings/presentation/provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPaymentScreen extends ConsumerStatefulWidget {
  final User user;
  final int? paymentIndex;
  const AddPaymentScreen({super.key, required this.user, this.paymentIndex});

  @override
  ConsumerState<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends ConsumerState<AddPaymentScreen> {
  final cardController = TextEditingController();
  final cvvController = TextEditingController();
  final expController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Pre-fill the text field if editing an cards
    if (widget.paymentIndex != null) {
      cardController.text = widget.user.cardNumber[widget.paymentIndex!];
    }
  }

  @override
  void dispose() {
    cardController.dispose();
    super.dispose();
  }

  void updateCards() {
    final cards = cardController.text.trim();

    if (cards.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid Card")),
      );
      return;
    }

    final notifier = ref.read(settingsProvider.notifier);
    final updatedcards = List<String>.from(widget.user.cardNumber);

    if (widget.paymentIndex != null) {
      // Edit existing cards
      updatedcards[widget.paymentIndex!] = cards;
    } else {
      // Add new cards
      updatedcards.add(cards);
    }

    notifier.updateUserProfile(
      uid: widget.user.uid,
      newCardnumber: updatedcards,
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
            text: "Add Payment",
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
                  controller: cardController,
                  hintText: "cards",
                  obsecureText: false),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: AppTextfield(
                        controller: expController,
                        hintText: "State",
                        obsecureText: false),
                  ),
                  Expanded(
                    child: AppTextfield(
                        controller: cvvController,
                        hintText: "Zip Code",
                        obsecureText: false),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              AppButton(onPressed: updateCards, text: "Save")
            ],
          ),
        ),
      ),
    );
  }
}
