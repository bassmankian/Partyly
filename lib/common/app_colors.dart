// presentation/themes/app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appTheme = ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android:
            CupertinoPageTransitionsBuilder(), // Slide up on iOS
        TargetPlatform.iOS:
            CupertinoPageTransitionsBuilder(), // Cupertino style on iOS
      },
    ),
    fontFamily: GoogleFonts.roboto().fontFamily,
    colorScheme: const ColorScheme.dark(
      primary: textColor,
      secondary: accentColor,
      background: mainColor,
    ));

const Color accentColor = Color.fromARGB(255, 255, 214, 50);
const Color mainColor = Color.fromRGBO(11, 0, 37, 1);
const Color textColor = Color(0xffe9e9e9);
const Color textSecendaryColor = Colors.grey;
const containerColor = Color.fromARGB(255, 34, 26, 63);
