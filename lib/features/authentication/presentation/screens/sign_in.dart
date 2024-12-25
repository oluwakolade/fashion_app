import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/core/constants/button.dart';
import 'package:fashion_app/core/responsive/responsve_scaffold.dart';
import 'package:fashion_app/features/authentication/presentation/provider/auth_provider.dart';
import 'package:fashion_app/features/authentication/presentation/widgets/textfield.dart';
import 'package:fashion_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends ConsumerStatefulWidget {
  final void Function()? togglePages;

  const SignInScreen({
    super.key,
    required this.togglePages,
  });

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String selectedLabel = '';

  Future<String?> getSelectedLabel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('selectedLabel');
  }

  @override
  void initState() {
    super.initState();
    getSelectedLabel().then((label) {
      if (label != null) {
        setState(() {
          selectedLabel = label;
        });
      }
    });
  }

//ref.read(authProvider.notifier)
  void signIn() {
    final String email = emailController.text;
    final String password = passwordController.text;

    final authNotifier = ref.read(authProvider.notifier);

    if (email.isNotEmpty && password.isNotEmpty) {
      authNotifier.login(email, password);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter both enail and password"),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return ResponsiveScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              AppText(
                text: "Sign in",
                color: theme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              const SizedBox(
                height: 20,
              ),
              //email address
              AppTextfield(
                  controller: emailController,
                  hintText: "Email Address",
                  obsecureText: false),
              const SizedBox(
                height: 15,
              ),
              //password
              AppTextfield(
                  controller: passwordController,
                  hintText: "Password",
                  obsecureText: true),
              const SizedBox(
                height: 25,
              ),

              //sign in button
              AppButton(onPressed: signIn, text: 'Sign In'),
              const SizedBox(
                height: 12,
              ),

              //others

              //dont have acount?
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppText(
                    text: "Don't have an Account? ",
                    color: theme.primary,
                  ),
                  InkWell(
                    onTap: widget.togglePages,
                    child: AppText(
                      text: "Create One",
                      color: theme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
