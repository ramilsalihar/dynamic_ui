import 'package:dynamic_ui/core/config/component.dart';
import 'package:dynamic_ui/core/config/screen_config.dart';
import 'package:dynamic_ui/core/service_locator.dart';
import 'package:flutter/material.dart';

class FirstTabScreen extends StatelessWidget {
  const FirstTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenConfigController = getIt<ScreenConfigController>();
    final screenConfig = screenConfigController.screenConfig;
    final backgroundColor = screenConfigController.backgroundColor;


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
        return const SizedBox.shrink();
    }
  }
}
