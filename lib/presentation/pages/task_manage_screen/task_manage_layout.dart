import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/context_extensions.dart';
import 'package:todo/core/router/router.dart';
import 'package:todo/core/theme/palette.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/presentation/pages/main_screen/bloc/main_bloc.dart';
import 'package:todo/presentation/tokens/spacing.dart';
import 'package:todo/presentation/widgets/date_field_widget.dart';
import 'package:todo/presentation/widgets/description_field_widget.dart';
import 'package:todo/presentation/widgets/file_attachment_widget.dart';
import 'package:todo/presentation/widgets/task_action_button.dart';
import 'package:todo/presentation/widgets/task_manager_app_bar.dart';
import 'package:todo/presentation/widgets/type_button_widget.dart';
import 'package:todo/presentation/widgets/urgent_task_field.dart';

class TaskManageLayout extends StatefulWidget {
  const TaskManageLayout({super.key, this.task, required this.tasks});

  final Task? task;
  final List<Task> tasks;

  @override
  State<TaskManageLayout> createState() => _TaskManageLayoutState();
}

class _TaskManageLayoutState extends State<TaskManageLayout> {
  late int _newTaskId;
  int selectedFilter = 1;
  bool isUrgent = false;
  String? _formattedDate;

  final _titleFocusNode = FocusNode();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _newTaskId = int.parse(widget.task!.taskId);
      _titleController.text = widget.task!.name;
      _descriptionController.text = widget.task!.description ?? '';
      selectedFilter = widget.task!.type;
      isUrgent = widget.task!.urgent == 1;
      _formattedDate = widget.task!.finishDate.toIso8601String();
    } else {
      _newTaskId = (widget.tasks.isNotEmpty
              ? widget.tasks
                  .map((task) => int.parse(task.taskId))
                  .reduce((a, b) => a > b ? a : b)
              : 0) +
          1;
    }
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onDateChanged(String? date) => setState(() => _formattedDate = date);

  void _onUrgentChanged(int urgentIndex) =>
      setState(() => isUrgent = urgentIndex == 1);

  void _createOrUpdateTask() {
    final task = Task(
      taskId: _newTaskId.toString(),
      status: widget.task?.status ?? 1,
      name: _titleController.text,
      type: selectedFilter,
      description: _descriptionController.text.isNotEmpty
          ? _descriptionController.text
          : null,
      finishDate: DateTime.parse(_formattedDate!),
      urgent: isUrgent ? 1 : 0,
    );

    context.read<MainBloc>().add(CreateTaskEvent(task));
  }

  void _deleteTask() =>
      context.read<MainBloc>().add(DeleteTaskEvent(widget.task!.taskId));

  bool _isFormValid() =>
      _titleController.text.isNotEmpty && _formattedDate != null;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: TaskManageAppBar(
            titleController: _titleController,
            titleFocusNode: _titleFocusNode,
            onSave: _isFormValid() ? _createOrUpdateTask : null,
            isEditing: widget.task != null,
          ),
          backgroundColor: Palette.backgroundColor,
          body: BlocConsumer<MainBloc, MainState>(
            listener: (context, state) {
              if (state is MainLoadedState) {
                context.r.replaceAll([MainRoute(tasks: state.tasks)]);
              } else if (state is MainErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.exception}')),
                );
              }
            },
            builder: (context, state) {
              if (state is MainDeletingState) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                children: [
                  Spacings.spacer24,
                  TypeButtonWidget(
                    selectedFilter: selectedFilter,
                    onFilterChanged: (index) =>
                        setState(() => selectedFilter = index),
                  ),
                  Spacings.spacer8,
                  DescriptionFieldWidget(
                    descriptionController: _descriptionController,
                  ),
                  Spacings.spacer8,
                  const FileAttachmentWidget(),
                  Spacings.spacer8,
                  CompletionDateWidget(
                    initialDate: _formattedDate,
                    onDateChanged: _onDateChanged,
                  ),
                  Spacings.spacer8,
                  UrgentTaskWidget(
                    isUrgent: isUrgent,
                    onUrgentChanged: _onUrgentChanged,
                  ),
                  Spacings.spacer24,
                  TaskActionButtons(
                    isEditing: widget.task != null,
                    isFormValid: _isFormValid(),
                    onCreateOrUpdate: _createOrUpdateTask,
                    onDelete: _deleteTask,
                  ),
                ],
              );
            },
          ),
        ),
      );
}
