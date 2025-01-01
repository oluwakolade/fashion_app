import 'package:fashion_app/features/settings/domain/repo/user_settings_repo.dart';
import 'package:fashion_app/features/settings/presentation/provider/settings_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsNotifier extends StateNotifier<SettingsState> {
  final SettingsRepo settingsRepo;

  SettingsNotifier({required this.settingsRepo}) : super(SettingsInitial());

  Future<void> fetchUserProfile(String uid) async {
    try {
      state = SettingsLoading();
      final user = await settingsRepo.fetchUserProfile(uid);

      if (user != null) {
        state = SettingsLoaded(user);
        print(state);
      } else {
        state = SettingsError('user not found');
      }
    } catch (e) {
      state = SettingsError(e.toString());
      print(e.toString());
    }
  }

  Future<void> updateUserProfile(
      {required String uid,
      List<String>? newAddress,
      List<String>? newCardnumber}) async {
    state = SettingsLoading();
    try {
      final currentUser = await settingsRepo.fetchUserProfile(uid);

      if (currentUser == null) {
        state = SettingsError('User not found');
        return;
      }

      final updatedProfile = currentUser.copyWith(
          newAddress: newAddress ?? currentUser.address,
          newCardNumber: newCardnumber ?? currentUser.cardNumber);

      await settingsRepo.updateUserProfile(updatedProfile);

      await fetchUserProfile(uid);
    } catch (e) {
      state = SettingsError(e.toString());
    }
  }
}
