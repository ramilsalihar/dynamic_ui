import 'dart:convert';
import 'package:dynamic_ui/core/dummy_data.dart';
import 'package:dynamic_ui/models/screen_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstTabScreen extends StatelessWidget {
  const FirstTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenConfig = ScreenConfig.fromJson(
      json.decode(jsonString) as Map<String, dynamic>,
    );

    final backgroundColor = Color(
      int.parse('0xFF${screenConfig.backgroundColor}'),
    );

    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: screenConfig.components.map((component) {
            return _buildComponent(component);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildComponent(Component component) {
    switch (component.type) {
      case 'textView':
        return Text(
          component.params['text'] ?? 'Default Text',
          style: TextStyle(
            fontSize: (component.params['size'] ?? 16).toDouble(),
            color: Color(
                int.parse('0xFF${component.params['color'] ?? '000000'}')),
          ),
        );
      case 'margin':
        return SizedBox(
          height: (component.params['paddingV'] ?? 8).toDouble(),
          width: (component.params['paddingH'] ?? 8).toDouble(),
        );
      case 'input':
        return TextField(
          decoration: InputDecoration(
            labelText: component.params['inputName'] ?? 'Input',
            labelStyle: TextStyle(
              color: Color(int.parse('0xFF${component.params['color']}')),
            ),
          ),
        );
      case 'nextButton':
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Color(int.parse('0xFF${component.params['color']}')),
          ),
          onPressed: () {},
          child: Text(component.params['text'] ?? 'Button'),
        );
      default:
        return SizedBox.shrink();
    }
  }
}
