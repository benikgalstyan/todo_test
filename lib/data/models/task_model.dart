import 'package:intl/intl.dart';

class Task {
  Task({
    required this.taskId,
    required this.status,
    required this.name,
    required this.type,
    this.description,
    required this.finishDate,
    required this.urgent,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskId: json['taskId'] as String,
      status: json['status'] as int,
      name: json['name'] as String,
      type: json['type'] as int,
      description: json['description'] as String?,
      finishDate: DateTime.parse(json['finishDate'] as String),
      urgent: json['urgent'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'taskId': taskId,
        'status': status,
        'name': name,
        'type': type,
        'description': description,
        'finishDate': finishDate.toIso8601String(),
        'urgent': urgent,
      };

  String get formattedFinishDate {
    return DateFormat('dd/MM/yyyy').format(finishDate);
  }

  final String taskId;
  int status;
  final String name;
  final int type;
  final String? description;
  final DateTime finishDate;
  final int urgent;
}
