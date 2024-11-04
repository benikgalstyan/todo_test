import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/data/repository/repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.repository) : super(LoginInitialState()) {
    on<LoadTasksEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        final tasks = await repository.getTasks();
        await repository.saveTasks(tasks);
        emit(TaskLoadedState(tasks: tasks));
      } catch (e) {
        try {
          final localTasks = await repository.getLocalTasks();
          emit(TaskLoadedState(tasks: localTasks));
        } catch (localError) {
          emit(LoginErrorState(e));
        }
      }
    });
  }

  final Repository repository;
}
