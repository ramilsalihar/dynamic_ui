import 'package:dynamic_ui/core/config/screen_config.dart';
import 'package:dynamic_ui/core/mixin/dialog_helper.dart';
import 'package:dynamic_ui/core/service_locator.dart';
import 'package:dynamic_ui/core/theme.dart';
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

class SecondTabScreenState extends ConsumerState<SecondTabScreen>
    with DialogHelper {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await ref.read(taskNotifierProvider.notifier).loadTasks();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _onRefresh() async {
    await _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final screenConfigController = getIt<ScreenConfigController>();
    final tasks = ref.watch(taskNotifierProvider);
    final taskNotifier = ref.read(taskNotifierProvider.notifier);
    final backgroundColor = screenConfigController.backgroundColor;
    final theme = ref.read(themeManagerProvider);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: Color(0xff00c6cf),
        ),
      )
          : tasks.isEmpty
          ? Center(
        child: Text(
          'No tasks available.',
          style: theme.textTheme.headlineLarge!.copyWith(
            color: Colors.white,
          ),
        ),
      )
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: _isLoading ? null : () async {
              await _onRefresh();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tasks refreshed')),
              );
            },
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: _isLoading ? null : () async {
              showTaskAddDialog(
                context: context,
                theme: theme,
                onAddTask: (value) {
                  final newTask = Task(
                    taskId: DateTime.now().millisecondsSinceEpoch.toString(),
                    createdAt: DateTime.now(),
                    status: value,
                  );
                  taskNotifier.addTask(newTask);
                },
              );
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