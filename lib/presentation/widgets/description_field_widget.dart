import 'package:flutter/material.dart';
import 'package:todo/core/context_extensions.dart';
import 'package:todo/core/theme/palette.dart';
import 'package:todo/core/theme/text_styles.dart';
import 'package:todo/presentation/tokens/spacing.dart';

class DescriptionFieldWidget extends StatefulWidget {
  const DescriptionFieldWidget({
    super.key,
    required this.descriptionController,
  });

  final TextEditingController descriptionController;

  @override
  State<DescriptionFieldWidget> createState() => _DescriptionFieldWidgetState();
}

class _DescriptionFieldWidgetState extends State<DescriptionFieldWidget> {
  static const maxLines = 3;
  final _focusNode = FocusNode();
  bool _isDescriptionFocused = false;
  static const containerHeight = 98.0;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isDescriptionFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Container(
        height: containerHeight,
        color: Palette.dateColor,
        padding: Spacings.paddingH16,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_focusNode),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  controller: widget.descriptionController,
                  focusNode: _focusNode,
                  style: TextStyles.textFieldStyle,
                  maxLines: maxLines,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:
                        _isDescriptionFocused ? '' : context.s.addDescription,
                    hintStyle: TextStyles.textFieldStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
