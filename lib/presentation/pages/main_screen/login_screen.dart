import 'package:todo/service_locator.dart';
import 'package:todo/data/repository/repository.dart';
import 'package:todo/presentation/pages/main_screen/bloc/login_bloc.dart';
import 'package:todo/presentation/pages/main_screen/login_layout.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const nameRoute = '/LoginScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(getIt<Repository>()),
      child: const LoginLayout(),
    );
  }
}
