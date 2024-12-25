import 'package:fashion_app/core/constants/app_text.dart';
import 'package:fashion_app/core/constants/button.dart';
import 'package:fashion_app/core/responsive/responsve_scaffold.dart';
import 'package:fashion_app/features/authentication/presentation/provider/auth_provider.dart';
import 'package:fashion_app/features/authentication/presentation/widgets/onboard_btn.dart';
import 'package:fashion_app/features/authentication/presentation/widgets/onboard_dropdown.dart';
import 'package:fashion_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Onboarding extends ConsumerWidget {
  const Onboarding({super.key});

  // String selectedLabel = "";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLabel = ref.watch(selectedLabelProvider);

    void setSelectedLabel(label) {
      ref.read(selectedLabelProvider.notifier).state = label;
    }

    return ResponsiveScaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            const SizedBox(
              height: 30,
            ),
            const AppText(
                text: 'Tell us About yourself',
                fontSize: 24,
                fontWeight: FontWeight.bold),
            const AppText(
              text: 'Who do you shop for?',
              fontSize: 16,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  OnboardButton(
                    label: 'Man',
                    isSelected: selectedLabel == 'Man',
                    onSelected: setSelectedLabel,
                  ),
                  OnboardButton(
                    label: 'Woman',
                    isSelected: selectedLabel == 'Woman',
                    onSelected: setSelectedLabel,
                  ),
                ]),
            const AppText(
              text: 'How old are you?',
              fontSize: 16,
            ),
            const OnboardDropdown(),
            const Spacer(),
            AppButton(
                onPressed: () {
                  if (selectedLabel != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select who you shop for."),
                      ),
                    );
                  }
                },
                text: "Finish")
          ],
        ),
      )),
    );
  }
}













































   // if (selectedLabel.isNotEmpty) {
                  //   await saveSelectedLabel(selectedLabel); // Save selection
                  //   // Navigate to HomeScreen with the selected label
                  //   if (!context.mounted) return;
                  //   Navigator.of(context).push(
                  //     MaterialPageRoute(
                  //       builder: (context) => HomeScreen(
                  //         selectedLabel: selectedLabel,
                  //       ),
                  //     ),
                  //   );
                  // } else {
                  //   // Show error if no button is selected
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(
                  //       content: Text("Please select who you shop for."),
                  //     ),
                  //   );
                  // }