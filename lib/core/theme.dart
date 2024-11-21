import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final themeManagerProvider = StateNotifierProvider<ThemeManager, ThemeData>(
  (ref) => ThemeManager(defaultTheme),
);

final defaultTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xff00c6cf),
  ),
  textTheme: GoogleFonts.montserratTextTheme(
    const TextTheme(
      displayMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.teal,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
);

class ThemeManager extends StateNotifier<ThemeData> {
  ThemeManager(super.initialTheme);

  void updatePrimaryColor(Color newColor) {
    state = state.copyWith(
      primaryColor: newColor,
      appBarTheme: state.appBarTheme.copyWith(backgroundColor: newColor),
    );
  }
}
