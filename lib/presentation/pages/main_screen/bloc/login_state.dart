part of 'login_bloc.dart';


@immutable
abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class TaskLoadedState extends LoginState {
  TaskLoadedState({required this.tasks});

  final List<Task> tasks;
}

class LoginErrorState extends LoginState {
  LoginErrorState(this.exception);

  final Object exception;
}
