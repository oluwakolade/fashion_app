import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/core/constants/button.dart';
import 'package:fashion_app/core/responsive/responsve_scaffold.dart';
import 'package:fashion_app/features/authentication/presentation/widgets/onboard_btn.dart';
import 'package:fashion_app/features/authentication/presentation/widgets/onboard_dropdown.dart';
import 'package:fashion_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const AppText(
                text: 'Tell us About yourself',
                fontSize: 24,
                fontWeight: FontWeight.bold),
            const SizedBox(
              height: 15,
            ),
            const AppText(
              text: 'Who do you shop for?',
              fontSize: 16,
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              OnboardButton(label: 'Man'),
              SizedBox(width: 10),
              OnboardButton(label: 'Woman'),
            ]),
            const SizedBox(
              height: 15,
            ),
            const AppText(
              text: 'How old are you?',
              fontSize: 16,
            ),
            const SizedBox(
              height: 10,
            ),
            const OnboardDropdown(),
            const Spacer(),
            AppButton(
                onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    ),
                text: "Finish")
          ],
        ),
      )),
    );
  }
}
