import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/context_extensions.dart';
import 'package:todo/core/router/router.dart';
import 'package:todo/core/theme/palette.dart';
import 'package:todo/core/theme/text_styles.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/presentation/pages/main_screen/bloc/main_bloc.dart';
import 'package:todo/presentation/tokens/spacing.dart';
import 'package:todo/presentation/widgets/custom_button.dart';
import 'package:todo/presentation/widgets/date_field_widget.dart';
import 'package:todo/presentation/widgets/description_field_widget.dart';
import 'package:todo/presentation/widgets/file_attachment_widget.dart';
import 'package:todo/presentation/widgets/type_button_widget.dart';
import 'package:todo/presentation/widgets/urgent_task_field.dart';

class TaskCreationLayout extends StatefulWidget {
  const TaskCreationLayout({super.key, required this.taskId});

  final int taskId;

  @override
  State<TaskCreationLayout> createState() => _TaskCreationLayoutState();
}

class _TaskCreationLayoutState extends State<TaskCreationLayout> {
  late int _lastTaskId;
  int selectedFilter = 1;
  bool isUrgent = false;
  String? _formattedDate;

  final _titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _lastTaskId = widget.taskId;
  }

  @override
  void dispose() {
    _titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _onDateChanged(date) => setState(() => _formattedDate = date);

  void _onUrgentChanged(urgentIndex) =>
      setState(() => isUrgent = urgentIndex == 1);

  void _toggleFilter(index) => setState(() => selectedFilter = index);

  void _dismissKeyboard() => FocusScope.of(context).unfocus();

  void _createTask() {
    final task = Task(
      taskId: (_lastTaskId + 1).toString(),
      status: 1,
      name: _titleController.text,
      type: selectedFilter,
      description: descriptionController.text.isNotEmpty
          ? descriptionController.text
          : null,
      finishDate: DateTime.parse(_formattedDate!),
      urgent: isUrgent ? 1 : 0,
    );

    context.read<MainBloc>().add(CreateTaskEvent(task));
  }

  bool _isFormValid() {
    return _titleController.text.isNotEmpty && _formattedDate != null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _dismissKeyboard,
      child: BlocListener<MainBloc, MainState>(
        listener: (context, state) {
          if (state is MainLoadedState) {
            context.r.replaceAll([MainRoute(tasks: state.tasks)]);
          } else if (state is MainErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.exception}')),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Palette.backgroundColor,
          appBar: AppBar(
            surfaceTintColor: null,
            backgroundColor: Palette.backgroundColor,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Palette.primaryButtonColor,
              ),
              onPressed: () => context.r.maybePop(),
            ),
            title: TextField(
              controller: _titleController,
              style: TextStyles.textFieldStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: context.s.nameOfTask,
                hintStyle: TextStyles.hintTextStyle,
              ),
            ),
          ),
          body: Center(
            child: Column(
              children: [
                Spacings.spacer24,
                TypeButtonWidget(
                  selectedFilter: selectedFilter,
                  onFilterChanged: _toggleFilter,
                ),
                Spacings.spacer8,
                DescriptionFieldWidget(
                  descriptionController: descriptionController,
                ),
                Spacings.spacer8,
                // TODO(Benik): implement later
                const FileAttachmentWidget(),
                Spacings.spacer8,
                CompletionDateWidget(onDateChanged: _onDateChanged),
                Spacings.spacer8,
                UrgentTaskWidget(onUrgentChanged: _onUrgentChanged),
                Spacings.spacer24,
                Padding(
                  padding: Spacings.paddingH16,
                  child: TODOElevatedButton.primary(
                    text: context.s.create,
                    isEnabled: _isFormValid(),
                    onPressed: _createTask,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
