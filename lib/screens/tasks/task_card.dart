import 'package:dynamic_ui/core/mixin/dialog_helper.dart';
import 'package:dynamic_ui/models/task.dart';
import 'package:dynamic_ui/notifiers/task_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskCard extends ConsumerWidget with DialogHelper {
  const TaskCard({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskNotifier = ref.read(taskNotifierProvider.notifier);

    return ListTile(
      title: Text('Task ID: ${task.taskId}'),
      subtitle: Text('Status: ${task.status}\n'
          'Created: ${task.createdAt}'),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          await taskNotifier.deleteTask(task.taskId);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Task deleted')),
          );
        },
      ),
      onTap: () => showTaskDetailsAlert(context, task),
    );
  }
}
