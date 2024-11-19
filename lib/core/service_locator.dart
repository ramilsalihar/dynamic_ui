import 'package:dynamic_ui/core/config/screen_config.dart';
import 'package:dynamic_ui/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<ScreenConfigController>(
    () => ScreenConfigController(),
  );
  getIt.registerLazySingleton<ThemeManager>(
    () => ThemeManager(ThemeData.light()),
  );
}
