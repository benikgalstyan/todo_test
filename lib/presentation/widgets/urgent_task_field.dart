import 'package:flutter/material.dart';
import 'package:todo/core/context_extensions.dart';
import 'package:todo/core/theme/palette.dart';
import 'package:todo/core/theme/text_styles.dart';
import 'package:todo/presentation/tokens/spacing.dart';

class UrgentTaskWidget extends StatefulWidget {
  const UrgentTaskWidget({
    super.key,
    required this.onUrgentChanged,
    this.isUrgent = false,
  });

  final ValueChanged<int> onUrgentChanged;
  final bool isUrgent;

  @override
  State<UrgentTaskWidget> createState() => _UrgentTaskWidgetState();
}

class _UrgentTaskWidgetState extends State<UrgentTaskWidget> {
  @override
  void initState() {
    super.initState();
    isUrgent = widget.isUrgent;
  }

  bool isUrgent = false;
  static const containerHeight = 50.0;

  void _toggleUrgent() {
    setState(() => isUrgent = !isUrgent);

    widget.onUrgentChanged(isUrgent ? 1 : 0);
  }

  IconData get getIcon =>
      isUrgent ? Icons.check_box : Icons.check_box_outline_blank;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: _toggleUrgent,
        child: Container(
          height: containerHeight,
          color: Palette.dateColor,
          child: Padding(
            padding: Spacings.paddingH16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(getIcon, color: Palette.borderColor),
                Spacings.spacer8,
                Text(context.s.urgent, style: TextStyles.attachTextStyle),
              ],
            ),
          ),
        ),
      );
}
