import 'package:flutter/material.dart';
import 'package:todo/core/theme/palette.dart';
import 'package:todo/generated/assets/fonts.gen.dart';

class TextStyles {
  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    fontFamily: FontFamily.sFUIDisplay,
  );
  static const taskNameStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Palette.taskTextColor,
    fontFamily: FontFamily.sFUIDisplay,
  );

  static const dateStyle = TextStyle(
    fontSize: 10,
    color: Palette.dateColor,
    fontFamily: FontFamily.sFUIDisplay,
    fontWeight: FontWeight.w400,
  );
  static const filterButtonsLabelStyle = TextStyle(
    fontSize: 18,
    fontFamily: FontFamily.sFUIDisplay,
  );
  static const hintTextStyle =
      TextStyle(color: Palette.hintColor, fontSize: 24);
  static const textFieldStyle = TextStyle(color: Colors.white);
  static const typeTextStyle = TextStyle(
    color: Colors.white,
    fontFamily: FontFamily.sFUIDisplay,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  static const attachTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
}
