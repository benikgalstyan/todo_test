import 'package:flutter/material.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/presentation/tokens/spacing.dart';
import 'package:todo/presentation/widgets/app_wrapper.dart';
import 'package:todo/presentation/widgets/filter_buttons.dart';
import 'package:todo/presentation/widgets/task_list.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key, required this.tasks});

  final List<Task> tasks;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedFilter = 0;

  List<Task> getFilteredTasks() => widget.tasks.where((task) {
        if (_selectedFilter == 1) return task.type == 1;
        if (_selectedFilter == 2) return task.type == 2;
        return true;
      }).toList();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: AppWrapper(
          child: Column(
            children: [
              FilterButtons(
                selectedFilter: _selectedFilter,
                onFilterChanged: (int newIndex) =>
                    setState(() => _selectedFilter = newIndex),
              ),
              Spacings.spacer24,
              TaskList(tasks: getFilteredTasks()),
              // Pass filtered tasks directly
            ],
          ),
        ),
      );
}
