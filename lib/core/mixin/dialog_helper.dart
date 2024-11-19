import 'package:flutter/material.dart';
import 'package:dynamic_ui/models/task.dart';

mixin DialogHelper {
  void showTaskDetailsAlert(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(task.status),
        content: Text('Task ID: ${task.taskId}\n'
            'Created At: ${task.createdAt}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
