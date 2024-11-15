import 'package:todo/presentation/tokens/spacing.dart';
import 'package:flutter/material.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: Spacings.padding16,
        child: child,
      ),
    );
  }
}
