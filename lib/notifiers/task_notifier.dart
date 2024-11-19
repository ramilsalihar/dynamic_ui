import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dynamic_ui/models/task.dart';
import 'package:dynamic_ui/services/task_service.dart';

final taskNotifierProvider =
StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  final taskService = TaskService();
  return TaskNotifier(taskService);
});

class TaskNotifier extends StateNotifier<List<Task>> {
  final TaskService _taskService;

  TaskNotifier(this._taskService) : super([]);

  Future<void> loadTasks() async {
    try {
      final tasks = await _taskService.getTasks();
      state = tasks;
    } catch (e) {
      print('Error loading tasks: $e');
    }
  }

  Future<void> addTask(Task task) async {
    try {
      await _taskService.addTask(task);
      state = [task, ...state];
    } catch (e) {
      print('Error adding task: $e');
    }
  }

  Future<void> editTask(String taskId, String newStatus) async {
    try {
      await _taskService.updateTaskStatus(taskId, newStatus);
      state = state.map((task) {
        if (task.taskId == taskId) {
          return Task(
            taskId: task.taskId,
            createdAt: task.createdAt,
            status: newStatus,
          );
        }
        return task;
      }).toList();
    } catch (e) {
      print('Error editing task: $e');
    }
  }


  Future<void> deleteTask(String taskId) async {
    try {
      await _taskService.updateTaskStatus(taskId, 'deleted');

      loadTasks();
    } catch (e) {
      print('Error deleting task: $e');
    }
  }

}



