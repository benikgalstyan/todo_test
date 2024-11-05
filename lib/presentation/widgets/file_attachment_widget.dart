import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/core/context_extensions.dart';
import 'package:todo/core/theme/palette.dart';
import 'package:todo/core/theme/text_styles.dart';
import 'package:todo/presentation/tokens/spacing.dart';

class FileAttachmentWidget extends StatefulWidget {
  const FileAttachmentWidget({super.key, required this.onFileSelected});

  final ValueChanged<File?> onFileSelected;

  @override
  State<FileAttachmentWidget> createState() => _FileAttachmentWidgetState();
}

class _FileAttachmentWidgetState extends State<FileAttachmentWidget> {
  File? _selectedImage;

  static const imageSize = 240.0;
  static const defaultHeight = 50.0;
  static const containerHeight = 320.0;

  Future<void> _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() => _selectedImage = File(returnedImage.path));
    widget.onFileSelected(_selectedImage);
  }

  @override
  Widget build(BuildContext context) => Container(
        height: _selectedImage != null ? containerHeight : defaultHeight,
        color: Palette.dateColor,
        child: Padding(
          padding: Spacings.paddingH16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: _pickImageFromGallery,
                child: _selectedImage != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacings.spacer16,
                          Text(
                            context.s.image,
                            style: TextStyles.attachTextStyle,
                          ),
                          Spacings.spacer8,
                          SizedBox(
                            width: imageSize,
                            height: imageSize,
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Spacings.spacer16,
                        ],
                      )
                    : Text(
                        context.s.attachFile,
                        style: TextStyles.attachTextStyle,
                      ),
              ),
            ],
          ),
        ),
      );
}
