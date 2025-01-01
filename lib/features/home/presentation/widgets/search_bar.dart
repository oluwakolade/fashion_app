import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSearchBar extends StatelessWidget {
  // final TextEditingController controller;

  const AppSearchBar({
    super.key,
    // required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: "Search...",
        fillColor: Theme.of(context).colorScheme.secondary,
        filled: true,
        hintStyle: GoogleFonts.montserrat(
            color: Theme.of(context).colorScheme.inversePrimary),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none),
      ),
    );
  }
}
