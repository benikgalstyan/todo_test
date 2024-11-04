import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/data/service/local_storage/local_storage_service.dart';

class SharedPrefsStorageService implements LocalStorageService {
  @override
  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> tasksJson =
        tasks.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList('tasks', tasksJson);
  }

  @override
  Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? tasksJson = prefs.getStringList('tasks');
    return tasksJson?.map((json) => Task.fromJson(jsonDecode(json))).toList() ??
        [];
  }
}
