import 'package:flutter/material.dart';

class Component {
  final String type;
  final Map<String, dynamic> params;

  Component({required this.type, required this.params});

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
      type: json['type'],
      params: json['params'] as Map<String, dynamic>,
    );
  }
}

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
