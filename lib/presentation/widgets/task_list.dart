import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/theme/palette.dart';
import 'package:todo/core/theme/text_styles.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/presentation/tokens/spacing.dart';
import 'package:todo/presentation/pages/main_screen/bloc/main_bloc.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key, required this.tasks, required this.onTaskTap});

  final List<Task> tasks;
  final ValueChanged<Task> onTaskTap;

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  static const endIconSize = 35.0;
  static const startIconSize = 30.0;
  final borderRadius = BorderRadius.circular(5);

  Color _getBackgroundColor(index) => widget.tasks[index].urgent == 1
      ? Palette.urgentColor
      : Palette.defaultContainerColor;

  IconData _getTaskEndIcon(index) => widget.tasks[index].status == 1
      ? Icons.check_box_outline_blank
      : Icons.check_box;

  IconData _getTaskStartIcon(index) =>
      widget.tasks[index].type == 1 ? Icons.work_outline : Icons.home_outlined;

  void _toggleTaskStatus(index) => setState(() {
        if (widget.tasks[index].status == 1) {
          widget.tasks[index].status = 2;
        } else {
          widget.tasks[index].status = 1;
        }
      });

  void _updateTask({required index, required newStatus}) =>
      context.read<MainBloc>().add(
            UpdateTaskStatusEvent(
              widget.tasks[index].taskId,
              newStatus,
            ),
          );

  @override
  Widget build(BuildContext context) => Expanded(
        child: ListView.builder(
          itemCount: widget.tasks.length,
          itemBuilder: (context, index) {
            final task = widget.tasks[index];
            return GestureDetector(
              onTap: () => widget.onTaskTap(task),
              child: Padding(
                padding: Spacings.paddingV8,
                child: Container(
                  padding: Spacings.padding8,
                  decoration: BoxDecoration(
                    color: _getBackgroundColor(index),
                    borderRadius: borderRadius,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getTaskStartIcon(index),
                        color: Palette.textColor,
                        size: startIconSize,
                      ),
                      Spacings.spacer12,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(task.name, style: TextStyles.taskNameStyle),
                            Spacings.spacer4,
                            Text(
                              task.formattedFinishDate,
                              style: TextStyles.dateStyle,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          final newStatus = task.status == 1 ? 2 : 1;
                          _toggleTaskStatus(index);
                          _updateTask(index: index, newStatus: newStatus);
                        },
                        icon: Icon(
                          size: endIconSize,
                          _getTaskEndIcon(index),
                          color: Palette.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
}
