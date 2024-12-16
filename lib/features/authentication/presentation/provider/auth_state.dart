import 'package:fashion_app/features/authentication/domain/entities/app_user.dart';

abstract class AuthState {}

//inital

class AuthIntial extends AuthState {}
//loading

class AuthLoading extends AuthState {}

//authenticated

class Authenticated extends AuthState {
  final AppUser user;
  Authenticated(this.user);
}

//unauthenticated

class UnAuthenticated extends AuthState {}

//errors

class AuthErrors extends AuthState {
  final String message;

  AuthErrors(this.message);
}
