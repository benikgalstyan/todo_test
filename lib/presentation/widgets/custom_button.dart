import 'package:flutter/material.dart';
import 'package:todo/core/theme/palette.dart';
import 'package:todo/core/theme/text_styles.dart';

enum ButtonType { primary, delete }

class TODOElevatedButton extends StatelessWidget {
  const TODOElevatedButton({
    super.key,
    this.type,
    this.isEnabled = true,
    required this.text,
    required this.onPressed,
  });

  factory TODOElevatedButton.primary({
    required String text,
    required bool isEnabled,
    required VoidCallback onPressed,
  }) =>
      TODOElevatedButton(
        text: text,
        isEnabled: isEnabled,
        onPressed: onPressed,
        type: ButtonType.primary,
      );

  factory TODOElevatedButton.delete({
    required String text,
    required bool isEnabled,
    required VoidCallback onPressed,
  }) =>
      TODOElevatedButton(
        text: text,
        onPressed: onPressed,
        isEnabled: isEnabled,
        type: ButtonType.delete,
      );

  final String text;
  final bool? isEnabled;
  final ButtonType? type;
  final VoidCallback? onPressed;

  static const elevation = 0.0;
  static const defaultHeight = 50.0;
  static const isButtonEnabled = true;
  static const buttonBorder = Radius.circular(15.0);

  VoidCallback? get _isButtonEnable => isEnabled! ? onPressed : null;

  @override
  Widget build(BuildContext context) {
    final buttonColor = switch (type) {
      ButtonType.primary => Palette.primaryButtonColor,
      ButtonType.delete => Palette.deleteButtonColor,
      _ => null,
    };

    Color? resolveButtonColor(Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return Palette.disabledButtonColor;
      }
      return buttonColor;
    }

    Color getButtonColor() {
      if (isEnabled!) {
        return Palette.textColor;
      } else {
        return Palette.dateColor;
      }
    }

    return SizedBox(
      height: defaultHeight,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isButtonEnable,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.resolveWith<Color?>(resolveButtonColor),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.all(buttonBorder),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style:
                  TextStyles.buttonTextStyle.copyWith(color: getButtonColor()),
            ),
          ],
        ),
      ),
    );
  }
}
