//possible operations for the app

import 'package:fashion_app/features/authentication/domain/entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailPassword(String email, String password);
  Future<AppUser?> registerWithEmailPassword(
      String lastName, String name, String email, String password);
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
}
