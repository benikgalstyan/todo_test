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
  static const _contentType = 'application/json';

  @override
  Future<List<Task>> getTasks() async {
    try {
      final response = await networkService.get<Map<String, dynamic>>(
        '$_baseUrl$tasksEndpoint',
        headers: {'Content-Type': _contentType},
      );

      final tasksData = response.data?['data'] as List<dynamic>? ?? [];
      return tasksData.map((json) => Task.fromJson(json)).toList();
    } catch (error) {
      rethrow;
    }
  }
}
