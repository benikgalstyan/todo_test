import 'package:flutter/material.dart';
import 'package:todo/core/context_extensions.dart';
import 'package:todo/core/theme/palette.dart';
import 'package:todo/core/theme/text_styles.dart';
import 'package:todo/presentation/tokens/spacing.dart';

class FileAttachmentWidget extends StatefulWidget {
  const FileAttachmentWidget({super.key});

  @override
  State<FileAttachmentWidget> createState() => _FileAttachmentWidgetState();
}

class _FileAttachmentWidgetState extends State<FileAttachmentWidget> {
  String? _fileName;
  static const containerHeight = 50.0;

  Future<void> _selectFile() async {
    const selectedFileName = 'example_file.txt';
    setState(() => _fileName = selectedFileName);
  }

  @override
  Widget build(BuildContext context) => Container(
        height: containerHeight,
        color: Palette.dateColor,
        child: Padding(
          padding: Spacings.paddingH16,
          child: Row(
            children: [
              GestureDetector(
                onTap: _selectFile,
                child: Text(
                  _fileName ?? context.s.attachFile,
                  style: TextStyles.attachTextStyle,
                ),
              ),
            ],
          ),
        ),
      );
}
