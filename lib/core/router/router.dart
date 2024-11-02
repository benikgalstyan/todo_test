import 'package:todo/presentation/pages/main_screen/main_screen.dart';
import 'package:todo/presentation/pages/second_screen/second_screen.dart';
import 'package:auto_route/auto_route.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MainRoute.page, path: MainScreen.nameRoute, initial: true),
        AutoRoute(page: SecondRoute.page, path: SecondScreen.nameRoute),
      ];
}
