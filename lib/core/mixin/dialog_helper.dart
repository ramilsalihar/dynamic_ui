import 'package:dynamic_ui/core/extensions/date_format.dart';
import 'package:dynamic_ui/widgets/status_picker.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_ui/models/task.dart';

mixin DialogHelper {
  void showTaskDetailsAlert({
    required BuildContext context,
    required Task task,
    required ThemeData theme,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        title: Center(
          child: Text(
            'Task Details',
            style: theme.textTheme.headlineLarge,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                style: theme.textTheme.headlineMedium, // Base style
                children: [
                  TextSpan(
                    text: 'Task ID: ',
                    style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${task.taskId}\n',
                  ),
                  TextSpan(
                    text: 'Created At: ',
                    style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: task.createdAt.toFormattedString(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: statusColors[task.status],
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                'Status: ${task.status}',
                style: theme.textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: theme.textTheme.headlineMedium,
            ),
          ),
        ],
      ),
    );
  }

  void showTaskAddDialog({
    required BuildContext context,
    required ThemeData theme,
    required Function(String) onAddTask,
  }) {
    var controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Add Task',
          style: theme.textTheme.headlineLarge,
        ),
        content: StatusPicker(controller: controller),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: theme.textTheme.headlineMedium!.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              onAddTask(controller.text);

              Navigator.pop(context);
            },
            child: Text(
              'Add',
              style: theme.textTheme.headlineMedium!.copyWith(
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showTaskEditDialog(
    BuildContext context,
    String initialStatus,
    ThemeData theme,
    Function(String) onEdit,
  ) {
    var controller = TextEditingController(text: initialStatus);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Edit Task Status',
              style: theme.textTheme.headlineLarge,
            ),
            content: StatusPicker(controller: controller),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Close',
                  style: theme.textTheme.headlineMedium!.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  onEdit(controller.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Task updated')),
                  );
                  Navigator.pop(context);
                },
                child: Text(
                  'Update',
                  style: theme.textTheme.headlineMedium!.copyWith(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
