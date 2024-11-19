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

  // Refresh logic
  Future<void> _onRefresh() async {
    await ref.read(taskNotifierProvider.notifier).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(taskNotifierProvider.notifier).loadTasks(),
          ),
        ],
      ),
      body: tasks.isEmpty
          ? const Center(child: Text('No tasks available.'))
          : RefreshIndicator(
        onRefresh: _onRefresh, // Refresh function triggered on pull-to-refresh
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return TaskCard(task: task);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Example task addition
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
    );
  }
}
