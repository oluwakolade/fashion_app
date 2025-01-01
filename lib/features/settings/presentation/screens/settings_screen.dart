import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/core/constants/progress_indicator.dart';
import 'package:fashion_app/core/responsive/responsve_scaffold.dart';
import 'package:fashion_app/features/authentication/presentation/provider/auth_provider.dart';
import 'package:fashion_app/features/settings/presentation/provider/settings_provider.dart';
import 'package:fashion_app/features/settings/presentation/provider/settings_state.dart';
import 'package:fashion_app/features/settings/presentation/screens/display_address.dart';
import 'package:fashion_app/features/settings/presentation/screens/display_cards.dart';
import 'package:fashion_app/features/settings/presentation/screens/favorites_screen.dart.dart';
import 'package:fashion_app/features/settings/presentation/widgets/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final authState = ref.read(authProvider.notifier);
      final uid = authState.currentUser?.uid ?? '';
      if (uid.isNotEmpty) {
        ref.read(settingsProvider.notifier).fetchUserProfile(uid);
      } else {
        debugPrint('User ID is empty');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(settingsProvider);
    final authState = ref.read(authProvider.notifier);

    void logOut() {
      authState.logout();
    }

    Widget spacing = const SizedBox(height: 10);

    return settingsState is SettingsLoaded
        ? ResponsiveScaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  //image
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.tertiary,
                        size: 35,
                      ),
                    ),
                  ),

                  //name
                  SettingsTile(
                    title:
                        '${settingsState.user.name} ${settingsState.user.lastName}',
                    subtitle: AppText(
                      text: settingsState.user.email,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 14,
                    ),
                    trailingWidget: TextButton(
                      onPressed: () {},
                      child: AppText(
                        text: "Edit",
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  //settings tile
                  SizedBox(
                    height: 250,
                    child: ListView(
                      children: [
                        //address
                        SettingsTile(
                          title: "Address",
                          trailingWidget: const Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DisplayAddress(
                                  user: settingsState.user,
                                ),
                              ),
                            );
                          },
                        ),
                        spacing,
                        //wishlist
                        SettingsTile(
                          title: "Favorites",
                          trailingWidget: const Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const FavoritesScreen(),
                              ),
                            );
                          },
                        ),
                        spacing,

                        //payment
                        SettingsTile(
                          title: "Payment",
                          trailingWidget: const Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DisplayCards(
                                  user: settingsState.user,
                                ),
                              ),
                            );
                          },
                        ),
                        spacing,

                        //help
                        SettingsTile(
                          title: "Help",
                          trailingWidget: const Icon(Icons.chevron_right),
                          onTap: () {},
                        ),
                        spacing,
                      ],
                    ),
                  ),

                  //sign out
                  TextButton(
                    onPressed: logOut,
                    child: const AppText(
                      text: "Sign out",
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          )
        : (settingsState is SettingsError)
            ? const Center(
                child: Center(child: Text('error')),
              )
            : const Center(
                child: AppLoadingIndicator(),
              );
  }
}
