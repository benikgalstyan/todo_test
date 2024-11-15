part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class UpdateTaskStatusEvent extends MainEvent {
  UpdateTaskStatusEvent(this.taskId, this.newStatus);

  final String taskId;
  final int newStatus;
}

class CreateTaskEvent extends MainEvent {
  CreateTaskEvent(this.task);

  final Task task;
}

class DeleteTaskEvent extends MainEvent {
  DeleteTaskEvent(this.taskId);

  final String taskId;
}
