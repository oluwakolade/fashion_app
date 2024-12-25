import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;

  const AppText(
      {super.key,
      required this.text,
      this.color,
      this.fontSize,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
          color: Theme.of(context).colorScheme.primary,
          fontSize: fontSize,
          fontWeight: fontWeight),
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }
}
