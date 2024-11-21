import 'package:dynamic_ui/core/extensions/date_format.dart';
import 'package:dynamic_ui/core/mixin/dialog_helper.dart';
import 'package:dynamic_ui/core/theme.dart';
import 'package:dynamic_ui/models/task.dart';
import 'package:dynamic_ui/notifiers/task_notifier.dart';
import 'package:dynamic_ui/widgets/status_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskCard extends ConsumerWidget with DialogHelper {
  const TaskCard({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskNotifier = ref.read(taskNotifierProvider.notifier);
    final theme = ref.read(themeManagerProvider);

    return GestureDetector(
      onTap: () {
        showTaskDetailsAlert(
          context: context,
          task: task,
          theme: theme,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: theme.primaryColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Task ID: ${task.taskId}',
                    style: theme.textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Created At: ${task.createdAt.toFormattedString()}',
                        style: theme.textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: statusColors[task.status],
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          'Status: ${task.status}',
                          style: theme.textTheme.headlineSmall!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.mode_edit_outline_rounded),
                    onPressed: () async {
                      showTaskEditDialog(
                        context,
                        task.status,
                        theme,
                        (value) {
                          taskNotifier.editTask(
                            task.taskId,
                            value,
                          );
                        },
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Task updated')),
                      );
                    },
                  ),
                  if (task.status != 'deleted')
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await taskNotifier.deleteTask(task.taskId);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Task deleted')),
                        );
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
