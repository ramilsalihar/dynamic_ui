import 'package:dynamic_ui/app.dart';
import 'package:dynamic_ui/core/config/screen_config.dart';
import 'package:dynamic_ui/core/service_locator.dart';
import 'package:dynamic_ui/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupLocator();
  final screenConfigController = getIt<ScreenConfigController>();
  try {
    final jsonString = await rootBundle.loadString('assets/screen_1.json');
    screenConfigController.loadConfig(jsonString);
    print('Screen configuration loaded');
    print('Background color: ${screenConfigController.backgroundColor}');
    screenConfigController.updatePrimaryColor(screenConfigController.backgroundColor);
  } catch (e) {
    print('Failed to load screen configuration: $e');
  }

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

