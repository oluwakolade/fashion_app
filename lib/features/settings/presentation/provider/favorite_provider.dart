import 'package:fashion_app/features/settings/data/firebase_user_settings.dart';
import 'package:fashion_app/features/settings/presentation/provider/favorite_notifier.dart';
import 'package:fashion_app/features/settings/presentation/provider/favorite_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesNotifierProvider =
    StateNotifierProvider<FavoritesNotifier, FavoritesState>((ref) {
  final settingsRepo = FirebaseUserSettings();
  return FavoritesNotifier(settingsRepo);
});
