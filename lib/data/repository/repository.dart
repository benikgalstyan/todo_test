import 'package:todo/data/models/task_model.dart';

abstract interface class Repository {
  Future<List<Task>> getTasks();
}
