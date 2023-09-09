import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: 'SFProText',
  primaryColor: const Color(0xFF00735f),
  primaryColorDark: const Color(0xff016655),
  disabledColor: const Color(0xFFBABFC4),
  scaffoldBackgroundColor: const Color(0xFF1C1F1F),
  brightness: Brightness.dark,
  hintColor: const Color(0xFF9F9F9F),
  cardColor: Colors.black26,
  textTheme:  const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Color(0xffd5e1e0)),
  ),
  colorScheme: const ColorScheme.dark(
      primary: Color(0xFF02B8A2),
      error: Color(0xFFE84D4F),
      background: Color(0xFFF3F3F3),
      secondary: Color(0xFF008C7B),
      tertiary: Color(0xFF7CCD8B),
      tertiaryContainer: Color(0xFFC98B3E),
      secondaryContainer: Color(0xFFEE6464),
      onTertiary: Color(0xFFD9D9D9),
      onSecondary: Color(0xFF00FEE1),
      onSecondaryContainer: Color(0xFFA8C5C1),
      onTertiaryContainer: Color(0xFF425956),
      outline: Color(0xFF8CFFF1),
      onPrimaryContainer: Color(0xFFDEFFFB),
      primaryContainer: Color(0xFFFFA800),
      onSurface: Color(0xFFFFE6AD),
      onPrimary: Color(0xFF14B19E)


  ),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color(0xFF00735f))),
);
