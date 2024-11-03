import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/data/repository/repository.dart';
import 'package:todo/presentation/pages/main_screen/bloc/main_bloc.dart';
import 'package:todo/presentation/pages/main_screen/main_layout.dart';
import 'package:todo/service_locator.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.tasks});

  final List<Task> tasks;

  static const nameRoute = '/MainScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainBloc(getIt<Repository>()),
      child:  MainLayout(tasks: tasks),
    );  }
}
