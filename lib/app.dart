import 'package:fashion_app/core/constants/progress_indicator.dart';
import 'package:fashion_app/core/themes/app_themes.dart';
import 'package:fashion_app/features/authentication/presentation/provider/auth_provider.dart';
import 'package:fashion_app/features/authentication/presentation/provider/auth_state.dart';
import 'package:fashion_app/features/authentication/presentation/screens/auth_screen.dart';
import 'package:fashion_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyAppThemes.lightTheme,
      darkTheme: MyAppThemes.darkTheme,
      home: Consumer(builder: (context, ref, child) {
        final authState = ref.watch(authProvider);

        if (authState is Authenticated) {
          return const HomeScreen();
        } else if (authState is UnAuthenticated) {
          return const AuthScreen();
        } else if (authState is AuthErrors) {
          return const Center(child: Text('Error'));
        } else {
          return const AuthScreen(); // Show the login screen as a fallback
        }
      }),
    );
  }
}
