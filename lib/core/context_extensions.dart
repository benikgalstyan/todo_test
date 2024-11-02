import 'package:todo/core/logger/composite_logger.dart';
import 'package:todo/core/logger/composite_logger_holder.dart';
import 'package:todo/core/router/app_router_holder.dart';
import 'package:todo/core/router/router.dart';
import 'package:todo/generated/l10n.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  S get s => S.of(this);

  CompositeLogger get l => CompositeLoggerHolder.of(this);

  ColorScheme get c => Theme.of(this).colorScheme;

  AppRouter get r => AppRouterHolder.of(this).router;

  MediaQueryData get q => MediaQuery.of(this);

  double get h => q.size.height;

  double get w => q.size.width;
}
