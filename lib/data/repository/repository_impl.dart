import 'package:todo/data/models/task_model.dart';
import 'package:todo/data/repository/repository.dart';
import 'package:todo/data/service/local_storage/local_storage_service.dart';
import 'package:todo/data/service/network_service/network_service.dart';

class RepositoryImpl implements Repository {
  RepositoryImpl({
    required this.networkService,
    required this.localStorageService,
  });

  final LocalStorageService localStorageService;
  final NetworkService networkService;

  static const _baseUrl =
      'https://to-do.softwars.com.ua/{galstyan.benik@gmail.com}';
  static const tasksEndpoint = '/tasks';
  static const _contentTypeValue = 'application/json';
  static const _contentTypeKey = 'Content-Type';

  @override
  Future<List<Task>> getTasks() async {
    try {
      final response = await networkService.get<Map<String, dynamic>>(
        '$_baseUrl$tasksEndpoint',
        headers: {'Content-Type': _contentTypeValue},
      );

      final tasksData = response.data?['data'] as List<dynamic>? ?? [];
      return tasksData.map((json) => Task.fromJson(json)).toList();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> updateTaskStatus(String taskId, int status) async {
    try {
      await networkService.put(
        '$_baseUrl$tasksEndpoint/$taskId',
        body: {
          'status': status,
        },
        headers: {_contentTypeKey: _contentTypeValue},
      );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> createTask(Task task) async {
    try {
      await networkService.post(
        '$_baseUrl$tasksEndpoint',
        body: [
          task.toJson(),
        ],
        headers: {_contentTypeKey: _contentTypeValue},
      );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    try {
      await networkService.delete(
        '$_baseUrl$tasksEndpoint/$taskId',
        headers: {_contentTypeKey: _contentTypeValue},
      );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> saveTasks(List<Task> tasks) =>
      localStorageService.saveTasks(tasks);

  @override
  Future<List<Task>> getLocalTasks() => localStorageService.getTasks();
}
