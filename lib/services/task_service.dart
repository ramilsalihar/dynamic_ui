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

  Future<void> updateTaskStatus(String taskId, String newStatus) async {
    await _tasksCollection.doc(taskId).update({'status': newStatus});
  }
}
