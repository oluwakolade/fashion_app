import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/core/responsive/responsve_scaffold.dart';
import 'package:fashion_app/features/settings/domain/entities/user.dart';
import 'package:fashion_app/features/settings/presentation/provider/settings_provider.dart';
import 'package:fashion_app/features/settings/presentation/provider/settings_state.dart';
import 'package:fashion_app/features/settings/presentation/screens/add_payment_screen.dart';
import 'package:fashion_app/features/settings/presentation/widgets/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisplayCards extends ConsumerWidget {
  final User user;
  const DisplayCards({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsProvider);

    // Handle different states
    if (settingsState is SettingsLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (settingsState is SettingsError) {
      return Center(child: Text(settingsState.errorMessage));
    }

    if (settingsState is SettingsLoaded) {
      final updatedUser = settingsState.user;

      return ResponsiveScaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Center(
            child: AppText(
              text: "Payment Cards",
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddPaymentScreen(
                      user: updatedUser,
                    ),
                  ),
                );
              },
              child: AppText(
                text: "Add ",
                fontSize: 12,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            )
          ],
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return SettingsTile(
                title: user.cardNumber[index],
                trailingWidget: (updatedUser.cardNumber.isEmpty)
                    ? const Icon(Icons.chevron_right)
                    : TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddPaymentScreen(
                                user: updatedUser,
                                paymentIndex: index,
                              ),
                            ),
                          );
                        },
                        child: AppText(
                          text: "Edit",
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
                  height: 10,
                ),
            itemCount: updatedUser.cardNumber.length),
      );
    }
    return const SizedBox();
  }
}
