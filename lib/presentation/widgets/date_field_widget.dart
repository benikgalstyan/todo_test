import 'package:flutter/material.dart';
import 'package:todo/core/context_extensions.dart';
import 'package:todo/core/theme/palette.dart';
import 'package:todo/core/theme/text_styles.dart';
import 'package:todo/presentation/tokens/spacing.dart';
import 'package:intl/intl.dart';

class CompletionDateWidget extends StatefulWidget {
  const CompletionDateWidget({
    super.key,
    required this.onDateChanged,
    this.initialDate,
  });

  final ValueChanged<String?> onDateChanged;
  final String? initialDate;

  @override
  State<CompletionDateWidget> createState() => _CompletionDateWidgetState();
}

class _CompletionDateWidgetState extends State<CompletionDateWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) {
      _selectedDate = DateTime.parse(widget.initialDate!);
    }
  }

  DateTime? _selectedDate;
  static const containerHeight = 50.0;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateChanged(getFormattedDate());
    }
  }

  String? getFormattedDate() {
    if (_selectedDate != null) {
      return DateFormat('yyyy-MM-dd').format(_selectedDate!);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) => Container(
        height: containerHeight,
        color: Palette.dateColor,
        child: Padding(
          padding: Spacings.paddingH16,
          child: GestureDetector(
            onTap: () => _selectDate(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (_selectedDate == null)
                  Text(context.s.deadline, style: TextStyles.attachTextStyle),
                Text(
                  _selectedDate != null
                      ? DateFormat('d MMMM yyyy', 'uk_UA')
                          .format(_selectedDate!)
                      : '',
                  style: TextStyles.attachTextStyle,
                ),
              ],
            ),
          ),
        ),
      );
}
