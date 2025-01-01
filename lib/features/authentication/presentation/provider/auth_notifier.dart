import 'package:fashion_app/features/authentication/domain/entities/app_user.dart';
import 'package:fashion_app/features/authentication/domain/repos/auth_repo.dart';
import 'package:fashion_app/features/authentication/presentation/provider/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthNotifier({required this.authRepo}) : super(AuthIntial());

  // bool isValidEmail(String email) {
  //   final emailRegex =
  //       RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  //   return emailRegex.hasMatch(email);
  // }

  //get current user

  //check if user is authenticated

  void checkAuth() async {
    final AppUser? user = await authRepo.getCurrentUser();
    if (user != null) {
      _currentUser = user;
      state = Authenticated(user);
    } else {
      state = UnAuthenticated();
    }
  }

  AppUser? get currentUser => _currentUser;

  // Login with email and password
  Future<void> login(String email, String password) async {
    try {
      state = AuthLoading();
      final user = await authRepo.loginWithEmailPassword(email, password);
      if (user != null) {
        _currentUser = user;
        print(_currentUser);

        state = Authenticated(user);
      } else {
        state = UnAuthenticated();
      }
    } catch (e) {
      state = AuthErrors(e.toString());
      print(e.toString());
      // state = UnAuthenticated();
    }
  }

  // Register a new user
  Future<void> register(
      String name, String email, String password, String lastName) async {
    // if (!isValidEmail(email)) {
    //   state = AuthErrors('Invalid email format');
    //   print(email);
    //   return;
    // }
    try {
      state = AuthLoading();
      final user = await authRepo.registerWithEmailPassword(
          name, email, password, lastName);
      if (user != null) {
        _currentUser = user;
        print(email);
        print(user);
        state = Authenticated(user);
      } else {
        state = UnAuthenticated();
      }
    } catch (e) {
      state = AuthErrors(e.toString());
      print(e.toString());

      // state = UnAuthenticated();
    }
  }

  // Logout the user
  Future<void> logout() async {
    await authRepo.logout();
    state = UnAuthenticated();
  }
}
