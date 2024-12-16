import 'package:fashion_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';

class OnboardDropdown extends StatefulWidget {
  const OnboardDropdown({super.key});

  @override
  State<OnboardDropdown> createState() => _OnboardDropdownState();
}

class _OnboardDropdownState extends State<OnboardDropdown> {
  String dropDownValue = "Age Range";

  List<String> items = ['18-24', '25-30', '31-45', '45-55', '55+'];
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        borderRadius: BorderRadius.circular(50),
        dropdownColor: Theme.of(context).colorScheme.secondary,
        value: dropDownValue,
        onChanged: (newValue) {
          setState(() {
            dropDownValue = newValue!;
          });
        },
        items: items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: AppText(text: item),
              ),
            )
            .toList());
  }
}
