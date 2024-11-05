import 'package:flutter/material.dart';
import 'package:todo/core/context_extensions.dart';
import 'package:todo/core/theme/palette.dart';
import 'package:todo/core/theme/text_styles.dart';

class TaskManageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskManageAppBar({
    super.key,
    required this.titleController,
    required this.titleFocusNode,
    required this.onSave,
    required this.isEditing,
  });

  final bool isEditing;
  final VoidCallback? onSave;
  final FocusNode titleFocusNode;
  final TextEditingController titleController;

  static const arrowBackIcon = Icon(
    Icons.arrow_back,
    color: Palette.primaryButtonColor,
  );
  static const acceptIcon = Icon(
    Icons.check,
    color: Palette.primaryButtonColor,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12),
      child: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Palette.backgroundColor,
        leading: IconButton(
          icon: arrowBackIcon,
          onPressed: () => context.r.maybePop(),
        ),
        title: TextField(
          controller: titleController,
          focusNode: titleFocusNode,
          style: TextStyles.textFieldStyle,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: titleFocusNode.hasFocus ? '' : context.s.nameOfTask,
            hintStyle: TextStyles.hintTextStyle,
          ),
        ),
        actions: isEditing
            ? [
                IconButton(icon: acceptIcon, onPressed: onSave),
              ]
            : null,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
