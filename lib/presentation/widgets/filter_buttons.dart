import 'package:flutter/material.dart';
import 'package:todo/core/context_extensions.dart';
import 'package:todo/core/theme/palette.dart';
import 'package:todo/core/theme/text_styles.dart';
import 'package:todo/presentation/tokens/spacing.dart';

class FilterButtons extends StatelessWidget {
  const FilterButtons({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  final int selectedFilter;
  final ValueChanged<int> onFilterChanged;

  static const _borderWidth = 2.0;
  static const _buttonWidth = 125.0;
  static const _buttonHeight = 37.0;

  @override
  Widget build(BuildContext context) {
    final filterLabels = [
      context.s.allTasks,
      context.s.work,
      context.s.personal,
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(filterLabels.length, (index) {
          final label = filterLabels[index];
          final isSelected = selectedFilter == index;
          final backgroundColor =
              isSelected ? Palette.borderColor : Palette.backgroundColor;
          final labelColor =
              isSelected ? Palette.textColor : Palette.borderColor;

          return Padding(
            padding: Spacings.paddingH8,
            child: SizedBox(
              width: _buttonWidth,
              height: _buttonHeight,
              child: ElevatedButton(
                onPressed: () => onFilterChanged(index),
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                  side: const BorderSide(
                    width: _borderWidth,
                    color: Palette.borderColor,
                  ),
                ),
                child: Text(
                  label,
                  style: TextStyles.filterButtonsLabelStyle
                      .copyWith(color: labelColor),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
