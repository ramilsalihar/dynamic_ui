import 'dart:convert';
import 'package:dynamic_ui/core/config/component.dart';
import 'package:dynamic_ui/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ScreenConfig {
  final String backgroundColor;
  final List<Component> components;

  ScreenConfig({required this.backgroundColor, required this.components});

  factory ScreenConfig.fromJson(Map<String, dynamic> json) {
    return ScreenConfig(
      backgroundColor: json['background_color'],
      components: (json['components'] as List)
          .map((e) => Component.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ScreenConfigController {
  late ScreenConfig screenConfig;
  late Color backgroundColor;

  void loadConfig(String jsonString) {
    screenConfig = ScreenConfig.fromJson(
      json.decode(jsonString) as Map<String, dynamic>,
    );
    backgroundColor = Color(
      int.parse('0xFF${screenConfig.backgroundColor}'),
    );
  }

  void updatePrimaryColor(Color backgroundColor) {
    final themeManager = GetIt.instance<ThemeManager>();
    themeManager.updatePrimaryColor(backgroundColor);
  }
}