import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<ThemeData> fetchInitialTheme() async {
  await Future.delayed(const Duration(seconds: 2));
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.teal,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.teal,
    ),
  );
}

final initialThemeProvider = FutureProvider<ThemeData>((ref) async {
  return fetchInitialTheme();
});

final themeManagerProvider =
    StateNotifierProvider<ThemeManager, ThemeData>((ref) {
  final initialTheme = ref.watch(initialThemeProvider).asData?.value;
  return ThemeManager(initialTheme ?? ThemeData.light());
});

class ThemeManager extends StateNotifier<ThemeData> {
  ThemeManager(super.initialTheme);

  void updatePrimaryColor(Color newColor) {
    state = state.copyWith(
      primaryColor: newColor,
      appBarTheme: AppBarTheme(backgroundColor: newColor),
    );
  }

  void toggleBrightness() {
    state = state.copyWith(
      brightness: state.brightness == Brightness.light
          ? Brightness.dark
          : Brightness.light,
    );
  }
}
