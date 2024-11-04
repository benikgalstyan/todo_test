import 'package:flutter/material.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/presentation/pages/login_screen/login_screen.dart';
import 'package:todo/presentation/pages/main_screen/main_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:todo/presentation/pages/task_creation_screen/task_creation_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LoginRoute.page,
          path: LoginScreen.nameRoute,
          initial: true,
        ),
        AutoRoute(page: MainRoute.page, path: MainScreen.nameRoute),
        AutoRoute(
          page: TaskCreationRoute.page,
          path: TaskCreationScreen.nameRoute,
        ),
      ];
}
