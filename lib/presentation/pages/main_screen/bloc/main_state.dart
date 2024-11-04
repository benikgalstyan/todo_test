part of 'main_bloc.dart';

@immutable
abstract class MainState {}

class MainInitialState extends MainState {}

class MainUpdatingState extends MainState {}

class MainLoadedState extends MainState {
  MainLoadedState({required this.tasks});

  final List<Task> tasks;
}

class MainErrorState extends MainState {
  MainErrorState(this.exception);

  final Object exception;
}

class MainCreatingState extends MainState {}

class MainDeletingState extends MainState {}
