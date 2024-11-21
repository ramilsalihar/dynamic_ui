import 'package:dynamic_ui/core/config/component.dart';
import 'package:dynamic_ui/core/config/screen_config.dart';
import 'package:dynamic_ui/core/service_locator.dart';
import 'package:dynamic_ui/core/theme.dart';
import 'package:dynamic_ui/widgets/dynamic_component_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirstTabScreen extends ConsumerWidget {
  const FirstTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenConfigController = getIt<ScreenConfigController>();
    final screenConfig = screenConfigController.screenConfig;
    final backgroundColor = screenConfigController.backgroundColor;

    final theme = ref.watch(themeManagerProvider);
    final inputController = TextEditingController();

    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: screenConfig.components
              .map((component) => _buildCustomComponent(
                    context: context,
                    theme: theme,
                    component: component,
                    inputController: inputController,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

Widget _buildCustomComponent({
  required BuildContext context,
  required ThemeData theme,
  required Component component,
  required TextEditingController inputController,
}) {
  final builder = DynamicComponentBuilder(context: context, theme: theme);

  switch (component.type) {
    case 'textView':
      return builder.build(
        Component(
          type: 'textView',
          params: {
            ...component.params,
          },
        ),
      );

    case 'input':
      return builder.build(
        Component(
          type: 'input',
          params: {
            ...component.params,
            'controller': inputController,
          },
        ),
      );

    case 'margin':
      return builder.build(
        Component(
          type: 'margin',
          params: {
            ...component.params,
          },
        ),
      );

    case 'nextButton':
      return builder.build(
        Component(
          type: 'nextButton',
          params: {
            ...component.params,
            'onPressed': () {
              print('Here is my email: ${inputController.text}');

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Submitted: ${inputController.text}'),
                ),
              );
            },
          },
        ),
      );

    default:
      return const SizedBox.shrink();
  }
}
