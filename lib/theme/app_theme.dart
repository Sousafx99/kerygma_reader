import 'package:flutter/material.dart';

enum ReaderThemeMode { light, sepia, dark, oled }

class AppTheme {
  static ThemeData getTheme(ReaderThemeMode mode, {bool isDark = false}) {
    switch (mode) {
      case ReaderThemeMode.light:
        return ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color(0xFFFBF9F5),
          colorScheme: const ColorScheme.light(
            surface: Color(0xFFFBF9F5),
            primary: Color(0xFF52453A),
            onPrimary: Colors.white,
            onSurface: Color(0xFF2C2B29),
            outline: Color(0x20000000),
          ),
        );
      case ReaderThemeMode.sepia:
        return ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color(0xFFF4ECD8),
          colorScheme: const ColorScheme.light(
            surface: Color(0xFFF4ECD8),
            primary: Color(0xFF52453A),
            onPrimary: Colors.white,
            onSurface: Color(0xFF3C3426),
            outline: Color(0x25000000),
          ),
        );
      case ReaderThemeMode.dark:
        return ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF18181B),
          colorScheme: const ColorScheme.dark(
            surface: Color(0xFF27272A),
            primary: Color(0xFFD4C7B8),
            onPrimary: Color(0xFF18181B),
            onSurface: Color(0xFFF4F4F5),
            outline: Color(0x30FFFFFF),
          ),
        );
      case ReaderThemeMode.oled:
        return ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          colorScheme: const ColorScheme.dark(
            surface: Color(0xFF121212),
            primary: Colors.white,
            onPrimary: Colors.black,
            onSurface: Color(0xFFE4E4E7),
            outline: Color(0x30FFFFFF),
          ),
        );
    }
  }
}
