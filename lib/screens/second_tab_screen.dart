import 'package:dynamic_ui/core/config/screen_config.dart';
import 'package:dynamic_ui/core/service_locator.dart';
import 'package:dynamic_ui/models/task.dart';
import 'package:dynamic_ui/notifiers/task_notifier.dart';
import 'package:dynamic_ui/screens/tasks/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecondTabScreen extends ConsumerStatefulWidget {
  const SecondTabScreen({super.key});

  @override
  SecondTabScreenState createState() => SecondTabScreenState();
}

class SecondTabScreenState extends ConsumerState<SecondTabScreen> {
  @override
  void initState() {
    super.initState();
    final taskNotifier = ref.read(taskNotifierProvider.notifier);
    taskNotifier.loadTasks();
  }

  Future<void> _onRefresh() async {
    await ref.read(taskNotifierProvider.notifier).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final screenConfigController = getIt<ScreenConfigController>();
    final tasks = ref.watch(taskNotifierProvider);
    final backgroundColor = screenConfigController.backgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: tasks.isEmpty
          ? const Center(child: Text('No tasks available.'))
          : RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 20),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return TaskCard(task: task);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              _onRefresh();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tasks refreshed')),
              );
            },
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () async {
              final newTask = Task(
                taskId: DateTime.now().millisecondsSinceEpoch.toString(),
                createdAt: DateTime.now(),
                status: 'active',
              );
              await ref.read(taskNotifierProvider.notifier).addTask(newTask);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Task added')),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
