import 'package:todo/data/models/task_model.dart';

abstract class LocalStorageService {
  Future<void> saveTasks(List<Task> tasks);

  Future<List<Task>> getTasks();
}
