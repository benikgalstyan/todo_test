import 'package:todo/data/models/task_model.dart';

abstract interface class Repository {
  Future<List<Task>> getTasks();

  Future<void> deleteTask(String taskId);

  Future<void> createTask(Task task);

  Future<void> updateTaskStatus(String taskId, int newStatus);

  Future<void> saveTasks(List<Task> tasks);

  Future<List<Task>> getLocalTasks();
}
