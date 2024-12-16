import 'package:fashion_app/features/authentication/domain/entities/app_user.dart';
import 'package:fashion_app/features/authentication/domain/repos/auth_repo.dart';
import 'package:fashion_app/features/authentication/presentation/provider/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepo authRepo;
  AuthNotifier({required this.authRepo}) : super(AuthIntial());
  AppUser? _currentUser;

  //get current user

  AppUser? get currentUser => _currentUser;

  //check if user is authenticated
  Future<void> chechAuth() async {
    try {
      final user = await authRepo.getCurrentUser();
      if (user != null) {
        _currentUser = user;
        state = Authenticated(user);
      } else {
        state = UnAuthenticated();
      }
    } catch (e) {
      state = AuthErrors(e.toString());
    }
  }

  // Login with email and password
  Future<void> login(String email, String password) async {
    try {
      state = AuthLoading();
      final user = await authRepo.loginWithEmailPassword(email, password);
      if (user != null) {
        _currentUser = user;
        state = Authenticated(user);
      } else {
        state = UnAuthenticated();
      }
    } catch (e) {
      state = AuthErrors(e.toString());
    }
  }

  // Register a new user
  Future<void> register(String name, String email, String password) async {
    try {
      state = AuthLoading();
      final user =
          await authRepo.registerWithEmailPassword(name, email, password);
      if (user != null) {
        _currentUser = user;
        state = Authenticated(user);
      } else {
        state = UnAuthenticated();
      }
    } catch (e) {
      state = AuthErrors(e.toString());
    }
  }

  // Logout the user
  Future<void> logout() async {
    try {
      await authRepo.logout();
      _currentUser = null;
      state = UnAuthenticated();
    } catch (e) {
      state = AuthErrors(e.toString());
    }
  }
}
