import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/data/repository/repository.dart';
import 'package:todo/presentation/pages/main_screen/bloc/main_bloc.dart';
import 'package:todo/presentation/pages/task_manage_screen/task_manage_layout.dart';
import 'package:todo/service_locator.dart';

@RoutePage()
class TaskManageScreen extends StatelessWidget {
  const TaskManageScreen({super.key, this.task, required this.tasks});

  final Task? task;
  final List<Task> tasks;

  static const nameRoute = '/CreateScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainBloc(getIt<Repository>()),
      child: TaskManageLayout(
        task: task,
        tasks: tasks,
      ),
    );
  }
}
