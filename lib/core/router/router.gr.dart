// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    MainRoute.name: (routeData) {
      final args = routeData.argsAs<MainRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MainScreen(
          key: args.key,
          tasks: args.tasks,
        ),
      );
    },
    TaskManageRoute.name: (routeData) {
      final args = routeData.argsAs<TaskManageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TaskManageScreen(
          key: args.key,
          task: args.task,
          tasks: args.tasks,
        ),
      );
    },
  };
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<MainRouteArgs> {
  MainRoute({
    Key? key,
    required List<Task> tasks,
    List<PageRouteInfo>? children,
  }) : super(
          MainRoute.name,
          args: MainRouteArgs(
            key: key,
            tasks: tasks,
          ),
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<MainRouteArgs> page = PageInfo<MainRouteArgs>(name);
}

class MainRouteArgs {
  const MainRouteArgs({
    this.key,
    required this.tasks,
  });

  final Key? key;

  final List<Task> tasks;

  @override
  String toString() {
    return 'MainRouteArgs{key: $key, tasks: $tasks}';
  }
}

/// generated route for
/// [TaskManageScreen]
class TaskManageRoute extends PageRouteInfo<TaskManageRouteArgs> {
  TaskManageRoute({
    Key? key,
    Task? task,
    required List<Task> tasks,
    List<PageRouteInfo>? children,
  }) : super(
          TaskManageRoute.name,
          args: TaskManageRouteArgs(
            key: key,
            task: task,
            tasks: tasks,
          ),
          initialChildren: children,
        );

  static const String name = 'TaskManageRoute';

  static const PageInfo<TaskManageRouteArgs> page =
      PageInfo<TaskManageRouteArgs>(name);
}

class TaskManageRouteArgs {
  const TaskManageRouteArgs({
    this.key,
    this.task,
    required this.tasks,
  });

  final Key? key;

  final Task? task;

  final List<Task> tasks;

  @override
  String toString() {
    return 'TaskManageRouteArgs{key: $key, task: $task, tasks: $tasks}';
  }
}
