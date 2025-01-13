import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFontStyle {
  static normalFont() {
    return GoogleFonts.roboto(
      fontSize: 14,
    );
  }

  static boldFont({double? size, Color? color}) {
    return GoogleFonts.roboto(
      fontSize: size ?? 14,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static buttonFont() {
    return GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.w700,
    );
  }
}
