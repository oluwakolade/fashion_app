import 'package:fashion_app/features/authentication/presentation/screens/sign_in.dart';
import 'package:fashion_app/features/authentication/presentation/screens/sign_up.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showLogin = true;

  void togglePages() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return SignInScreen(
        togglePages: togglePages,
      );
    } else {
      return SignUpScreen(
        togglePages: togglePages,
      );
    }
  }
}




// import 'package:bloc_social_media/features/authentication/presentation/pages/login_page.dart';
// import 'package:bloc_social_media/features/authentication/presentation/pages/register_page.dart';
// import 'package:flutter/material.dart';

// class AuthPage extends StatefulWidget {
//   const AuthPage({super.key});

//   @override
//   State<AuthPage> createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
//   bool showLogin = true;

//   void togglePages() {
//     setState(() {
//       showLogin = !showLogin;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (showLogin) {
//       return LoginPage(
//         togglePages: togglePages,
//       );
//     } else {
//       return RegisterPage(
//         togglePages: togglePages,
//       );
//     }
//   }
// }
