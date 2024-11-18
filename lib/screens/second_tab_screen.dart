import 'package:dynamic_ui/models/task.dart';
import 'package:dynamic_ui/services/task_service.dart';
import 'package:flutter/material.dart';

class SecondTabScreen extends StatefulWidget {
  const SecondTabScreen({super.key});

  @override
  State<SecondTabScreen> createState() => _SecondTabScreenState();
}

class _SecondTabScreenState extends State<SecondTabScreen> {
  final TaskService _taskService = TaskService();

  void _showTaskDetailsAlert(BuildContext context, Task task) {
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
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Task>>(
        future: _taskService.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading tasks.'));
          }

          final tasks = snapshot.data ?? [];

          if (tasks.isEmpty) {
            return const Center(child: Text('No tasks available.'));
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text('Task ID: ${task.taskId}'),
                subtitle: Text('Status: ${task.status}\n'
                    'Created: ${task.createdAt}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await _taskService.updateTaskStatus(task.taskId, 'deleted');
                    setState(() {}); // Refresh the list after deletion
                  },
                ),
                onTap: () => _showTaskDetailsAlert(context, task),
              );
            },
          );
        },
      ),
    );
  }
}
