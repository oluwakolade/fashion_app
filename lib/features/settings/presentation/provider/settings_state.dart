import 'package:fashion_app/features/settings/domain/entities/user.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final User user;

  SettingsLoaded(this.user);
}

class SettingsError extends SettingsState {
  final String errorMessage;

  SettingsError(this.errorMessage);
}
