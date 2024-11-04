import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/repository/repository.dart';
import 'package:todo/presentation/pages/main_screen/bloc/main_bloc.dart';
import 'package:todo/presentation/pages/task_creation_screen/task_creation_layout.dart';
import 'package:todo/service_locator.dart';

@RoutePage()
class TaskCreationScreen extends StatelessWidget {
  const TaskCreationScreen({super.key, required this.taskId});

  final int taskId;

  static const nameRoute = '/CreateScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainBloc(getIt<Repository>()),
      child: TaskCreationLayout(taskId: taskId),
    );
  }
}
