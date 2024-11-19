import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_ui/models/task.dart';

class TaskService {
  final FirebaseFirestore _tasksCollection = FirebaseFirestore.instance;

  Future<List<Task>> getTasks() async {
    List<Task> data = [];
    await _tasksCollection
        .collection('tasks')
        .orderBy('created_at', descending: true)
        .get()
        .then((QuerySnapshot? snapshot) {
      data = snapshot!.docs.map((e) => Task.fromFirestore(e)).toList();
    });
    return data;
  }


  Future<void> addTask(Task task) async {
    try {
      await _tasksCollection.collection('tasks').doc(task.taskId).set({
        'task_id': task.taskId,
        'created_at': task.createdAt,
        'status': task.status,
      });
    } catch (e) {
      throw Exception('Error adding task: $e');
    }
  }


  Future<void> editTask(String taskId, Map<String, dynamic> updates) async {
    try {
      await _tasksCollection.collection('tasks').doc(taskId).update(updates);
    } catch (e) {
      throw Exception('Error editing task: $e');
    }
  }


  Future<void> deleteTask(String taskId) async {
    try {
      await _tasksCollection.collection('tasks').doc(taskId).update({'status': 'deleted'});
    } catch (e) {
      throw Exception('Error deleting task: $e');
    }
  }

  Future<void> updateTaskStatus(String taskId, String newStatus) async {
    await _tasksCollection.collection('tasks').doc(taskId).update({'status': newStatus});
  }
}
