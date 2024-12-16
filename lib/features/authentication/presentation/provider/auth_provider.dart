import 'package:fashion_app/features/authentication/data/firebase_auth_repo.dart';
import 'package:fashion_app/features/authentication/domain/repos/auth_repo.dart';
import 'package:fashion_app/features/authentication/presentation/provider/auth_notifier.dart';
import 'package:fashion_app/features/authentication/presentation/provider/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepoProvider = Provider<AuthRepo>((ref) => FirebaseAuthRepo());

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return AuthNotifier(authRepo: authRepo);
});
