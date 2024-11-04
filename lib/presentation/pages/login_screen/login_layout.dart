import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/context_extensions.dart';
import 'package:todo/core/router/router.dart';
import 'package:todo/core/theme/palette.dart';
import 'package:todo/presentation/pages/login_screen/bloc/login_bloc.dart';
import 'package:todo/presentation/widgets/app_wrapper.dart';
import 'package:todo/presentation/widgets/custom_button.dart';

class LoginLayout extends StatefulWidget {
  const LoginLayout({super.key});

  @override
  State<LoginLayout> createState() => _LoginLayoutState();
}

class _LoginLayoutState extends State<LoginLayout> {
  static const upFlex = 2;
  static const downFlex = 1;

  void _login() => context.read<LoginBloc>().add(LoadTasksEvent());

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Palette.backgroundColor,
        body: AppWrapper(
          child: Center(
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is TaskLoadedState) {
                  context.r.replaceAll([MainRoute(tasks: state.tasks)]);
                } else if (state is LoginErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${state.exception}')),
                  );
                }
              },
              builder: (context, state) {
                if (state is LoginLoadingState) {
                  return const CircularProgressIndicator();
                }

                return Column(
                  children: [
                    const Spacer(flex: upFlex),
                    TODOElevatedButton.primary(
                      text: context.s.login,
                      isEnabled: true,
                      onPressed: _login,
                    ),
                    const Spacer(flex: downFlex),
                  ],
                );
              },
            ),
          ),
        ),
      );
}
