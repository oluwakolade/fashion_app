import 'package:fashion_app/features/settings/domain/repo/user_settings_repo.dart';
import 'package:fashion_app/features/settings/presentation/provider/favorite_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends StateNotifier<FavoritesState> {
  final SettingsRepo settingsRepo;

  FavoritesNotifier(this.settingsRepo) : super(FavoritesInitial());

  // Toggle favorites
  Future<void> toggleFavorites(String uid, String id) async {
    try {
      state = FavoritesLoading();

      await settingsRepo.toggleFavorite(uid, id);

      // final favorites = await settingsRepo.getUserFavorites(uid);

      final updatedFavorites = await settingsRepo.getUserFavorites(uid);

      state = FavoritesLoaded(updatedFavorites);
    } catch (e) {
      state = FavoritesError(e.toString());
    }
  }

  // Fetch user favorites
  Future<void> getUserFavorites(String uid) async {
    try {
      state = FavoritesLoading();

      final favorites = await settingsRepo.getUserFavorites(uid);

      state = FavoritesLoaded(favorites);
    } catch (e) {
      state = FavoritesError(e.toString());
    }
  }
}
