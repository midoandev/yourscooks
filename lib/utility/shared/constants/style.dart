import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yourscooks/utility/shared/constants/number_helper.dart';

import '../services/storage_service.dart';
import 'constants.dart';

class StyleConstants {
  static ThemeData lightThemeData = FlexThemeData.light(
    scheme: FlexScheme.ebonyClay,
    textTheme: textTheme,
    // fontFamily: GoogleFonts.ubuntu().fontFamily,
  );
  static ThemeData darkThemeData = FlexThemeData.dark(
    scheme: FlexScheme.ebonyClay,
    textTheme: textTheme,
    // fontFamily: GoogleFonts.outfit().fontFamily,
  );

  static Future<bool> get isLight async =>
      await StorageService.getPrefBool(key: StorageEnum.themeIsDark);

  static TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.outfit(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        // color: Colors.black54,
        letterSpacing: 3),
    displayMedium: GoogleFonts.outfit(
        fontSize: 45,
        fontWeight: FontWeight.w600,
        // color: Colors.black54,
        letterSpacing: 2),
    displaySmall: GoogleFonts.outfit(
      fontSize: 36,
      fontWeight: FontWeight.w500,
      // color: Colors.black54,
    ),
    headlineLarge: GoogleFonts.outfit(
      fontSize: 32,
      fontWeight: FontWeight.w800,
      // color: Colors.black54,
    ),
    headlineMedium: GoogleFonts.outfit(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      // color: Colors.black54,
      letterSpacing: 0.25,
    ),
    headlineSmall: GoogleFonts.outfit(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      // color: Colors.black.withOpacity(.6),
    ),
    titleLarge: GoogleFonts.outfit(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      // color: Colors.black.withOpacity(.6),
      letterSpacing: 2,
    ),
    titleMedium: GoogleFonts.outfit(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      // color: Colors.black.withOpacity(.6),
      letterSpacing: 1,
    ),
    titleSmall: GoogleFonts.outfit(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      // color: Colors.black.withOpacity(.6),
      letterSpacing: 0.1,
    ),
    bodyLarge: GoogleFonts.outfit(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      // color: Colors.black,
      letterSpacing: 0.5,
      height: 21.pxToDouble,
    ),
    bodyMedium: GoogleFonts.outfit(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      // color: Colors.black.withOpacity(.8),
      letterSpacing: 1.24,
      height: 19.pxToDouble,
    ),
    bodySmall: GoogleFonts.outfit(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      // color: Colors.black.withOpacity(.6),
      height: 19.pxToDouble,
    ),
    labelLarge: GoogleFonts.outfit(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      // color: Colors.black.withOpacity(.6),
      height: pxToDouble(px: 14.63),
      letterSpacing: 1.25,
    ),
    labelMedium: GoogleFonts.outfit(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      // color: Colors.black.withOpacity(.6),
      height: pxToDouble(px: 14.63),
      letterSpacing: 1,
    ),
    labelSmall: GoogleFonts.outfit(
      fontSize: 11,
      fontWeight: FontWeight.w300,
      // color: Colors.black.withOpacity(.6),
      height: pxToDouble(px: 14.63),
      letterSpacing: 1,
    ),
  );
}

extension SizeText on TextStyle {
  TextStyle get changeSizeText => copyWith(fontSize: fontSize! - 6);
}

