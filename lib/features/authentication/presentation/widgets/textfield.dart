import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextfield extends StatelessWidget {
  final TextEditingController controller;
  final bool obsecureText;
  final String hintText;

  const AppTextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obsecureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Theme.of(context).colorScheme.secondary,
        filled: true,
        hintStyle: GoogleFonts.montserrat(
            color: Theme.of(context).colorScheme.inversePrimary),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
      ),
    );
  }
}