import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String taskId;
  final DateTime createdAt;
  String status;

  Task({
    required this.taskId,
    required this.createdAt,
    required this.status,
  });

  factory Task.fromMap(Map<dynamic, dynamic> map) {
    return Task(
      taskId: map['task_id'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      status: map['status'] ?? '',
    );
  }


  factory Task.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Task(
      taskId: doc.id,
      createdAt: data['created_at'].toDate(),
      status: data['status'],
    );
  }
}