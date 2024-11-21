import 'package:dynamic_ui/core/config/component.dart';
import 'package:flutter/material.dart';

class DynamicComponentBuilder {
  final BuildContext context;
  final ThemeData theme;

  DynamicComponentBuilder({
    required this.context,
    required this.theme,
  });

  Widget build(Component component) {
    switch (component.type) {
      case 'textView':
        return _buildTextView(component);
      case 'margin':
        return _buildMargin(component);
      case 'input':
        return _buildInput(component);
      case 'nextButton':
        return _buildNextButton(component);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildTextView(Component component) {
    return Text(
      component.params['text'] ?? 'Default Text',
      style: theme.textTheme.headlineMedium?.copyWith(
        fontSize: (component.params['size'] ?? 16).toDouble(),
        color: Color(
          int.parse('0xFF${component.params['color'] ?? '000000'}'),
        ),
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildMargin(Component component) {
    return SizedBox(
      height: (component.params['paddingV'] ?? 8).toDouble(),
      width: (component.params['paddingH'] ?? 8).toDouble(),
    );
  }

  Widget _buildInput(Component component) {
    final controller = component.params['controller'] as TextEditingController?;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(int.parse('0xFF${component.params['color']}')),
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: TextFormField(
        controller: controller,
        style: theme.textTheme.headlineMedium?.copyWith(
          color: Color(int.parse('0xFF${component.params['color']}')),
        ),
        decoration: InputDecoration(
          labelText: component.params['inputName'] ?? 'Input',
          labelStyle: theme.textTheme.headlineMedium?.copyWith(
            color: Color(int.parse('0xFF${component.params['color']}')),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildNextButton(Component component) {
    final onPressed = component.params['onPressed'] as VoidCallback?;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 48,
          ),
          backgroundColor: Color(int.parse('0xFF${component.params['color']}')),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          component.params['text'] ?? 'Button',
          style: theme.textTheme.headlineMedium!.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}


