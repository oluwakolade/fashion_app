import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/core/constants/button.dart';
import 'package:fashion_app/core/responsive/responsve_scaffold.dart';
import 'package:fashion_app/features/authentication/presentation/provider/auth_provider.dart';
import 'package:fashion_app/features/authentication/presentation/screens/onboarding.dart';
import 'package:fashion_app/features/authentication/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  final void Function()? togglePages;
  const SignUpScreen({super.key, required this.togglePages});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  void createAccount() {
    final email = emailController.text;
    final password = passwordController.text;
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final authNotifier = ref.read(authProvider.notifier);
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        firstName.isNotEmpty &&
        lastName.isNotEmpty) {
      authNotifier.register(firstName, email, password);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Onboarding(),
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
                text: "Create Account",
                color: theme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              const SizedBox(
                height: 20,
              ),
              //first name
              AppTextfield(
                  controller: firstNameController,
                  hintText: "First Name",
                  obsecureText: false),
              const SizedBox(
                height: 12,
              ),
              //last name
              AppTextfield(
                  controller: lastNameController,
                  hintText: "Last Name",
                  obsecureText: false),
              const SizedBox(
                height: 12,
              ),
              //email address
              AppTextfield(
                  controller: emailController,
                  hintText: "Email Address",
                  obsecureText: false),
              const SizedBox(
                height: 12,
              ),
              //password
              AppTextfield(
                  controller: passwordController,
                  hintText: "Password",
                  obsecureText: true),
              const SizedBox(
                height: 20,
              ),

              //sign in button
              AppButton(onPressed: createAccount, text: 'Continue'),
              const SizedBox(
                height: 12,
              ),

              //others

              //dont have acount?
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppText(
                    text: "Already have an Account? ",
                    color: theme.primary,
                  ),
                  InkWell(
                    onTap: widget.togglePages,
                    child: AppText(
                      text: "Sign in",
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