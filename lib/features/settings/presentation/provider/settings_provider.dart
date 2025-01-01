import 'package:fashion_app/features/settings/data/firebase_user_settings.dart';
import 'package:fashion_app/features/settings/domain/repo/user_settings_repo.dart';
import 'package:fashion_app/features/settings/presentation/provider/settings_notifier.dart';
import 'package:fashion_app/features/settings/presentation/provider/settings_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  final settingsRepo = ref.watch(settingsRepoProvider);
  return SettingsNotifier(settingsRepo: settingsRepo);
});

final settingsRepoProvider = Provider<SettingsRepo>((ref) {
  return FirebaseUserSettings();
});
