import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/data/repository/repository.dart';

part 'main_state.dart';

part 'main_event.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc(this.repository) : super(MainInitialState()) {
    on<UpdateTaskStatusEvent>((event, emit) async {
      try {
        emit(MainUpdatingState());
        await repository.updateTaskStatus(event.taskId, event.newStatus);
        emit(MainUpdatedState());
        final tasks = await repository.getTasks();
        emit(MainLoadedState(tasks: tasks));
      } catch (e) {
        emit(MainErrorState(e));
      }
    });
  }

  final Repository repository;
}