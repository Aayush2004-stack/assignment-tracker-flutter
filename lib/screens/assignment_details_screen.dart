import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:assignment_tracker/app/app_theme.dart';
import 'package:assignment_tracker/provider/assignment_provider.dart';
import 'package:assignment_tracker/provider/module_provider.dart';
import 'package:assignment_tracker/provider/task_provider.dart';
import 'package:assignment_tracker/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AssignmentDetailsScreen extends StatefulWidget {
  final int assignmentId;
  const AssignmentDetailsScreen({super.key, required this.assignmentId});

  @override
  State<AssignmentDetailsScreen> createState() =>
      _AssignmentDetailsScreenState();
}

class _AssignmentDetailsScreenState extends State<AssignmentDetailsScreen> {
  final _taskFormKey = GlobalKey<FormState>();
  final _taskTitleController = TextEditingController();

  final _editAssignmentFormKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _detailsController = TextEditingController();
  final _givenDateController = TextEditingController();
  final _dueDateController = TextEditingController();

  int? _selectedModule;

  @override
  void dispose() {
    _taskTitleController.dispose();

    _titleController.dispose();
    _detailsController.dispose();
    _givenDateController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  Future<void> _addTask() async {
    if (!_taskFormKey.currentState!.validate()) {
      return;
    }

    final taskProvider = context.read<TaskProvider>();
    await taskProvider.addTask(
      widget.assignmentId,
      _taskTitleController.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Task added successfully')));

    _taskTitleController.clear();
  }

  void _showEditAssignmentDialog() {
    final assignment = context.read<AssignmentProvider>().assignment;

    if (assignment == null) {
      return;
    }

    _titleController.text = assignment.title;
    _detailsController.text = assignment.details;

    _givenDateController.text = DateFormat(
      'yyyy-MM-dd',
    ).format(assignment.givenDate);

    _dueDateController.text = DateFormat(
      'yyyy-MM-dd',
    ).format(assignment.deadline);

    _selectedModule = assignment.moduleId;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Assignment'),
          content: Form(
            key: _editAssignmentFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a title';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _detailsController,
                    decoration: const InputDecoration(labelText: 'Details'),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter details';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _givenDateController,
                    decoration: const InputDecoration(
                      labelText: 'Given Date (YYYY-MM-DD)',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a given date';
                      }

                      if (!RegExp(
                        r'^\d{4}-\d{2}-\d{2}$',
                      ).hasMatch(value.trim())) {
                        return 'Please enter a valid date';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _dueDateController,
                    decoration: const InputDecoration(
                      labelText: 'Due Date (YYYY-MM-DD)',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a due date';
                      }

                      if (!RegExp(
                        r'^\d{4}-\d{2}-\d{2}$',
                      ).hasMatch(value.trim())) {
                        return 'Please enter a valid date';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  Consumer<ModuleProvider>(
                    builder: (context, moduleProvider, _) {
                      return DropdownButtonFormField<int>(
                        value: _selectedModule,
                        decoration: const InputDecoration(labelText: 'Module'),
                        items: moduleProvider.modules.map((module) {
                          return DropdownMenuItem<int>(
                            value: module.moduleId,
                            child: Text(module.moduleName),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedModule = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a module';
                          }

                          return null;
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (!_editAssignmentFormKey.currentState!.validate()) {
                  return;
                }

                if (_selectedModule == null) {
                  return;
                }

                final assignmentProvider = context.read<AssignmentProvider>();

                await assignmentProvider.updateAssignment(
                  widget.assignmentId,
                  _titleController.text.trim(),
                  _detailsController.text.trim(),
                  _givenDateController.text.trim(),
                  _dueDateController.text.trim(),
                  _selectedModule!,
                );

                if (!mounted) return;

                Navigator.of(dialogContext).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Assignment updated successfully'),
                  ),
                );

                // Fetch the updated assignment details again.
                await assignmentProvider.fetchAssignmentDetails(
                  widget.assignmentId,
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      context.read<TaskProvider>().fetchTasks(
        assignmentId: widget.assignmentId,
      );

      context.read<AssignmentProvider>().fetchAssignmentDetails(
        widget.assignmentId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assignment Details')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer2<AssignmentProvider, TaskProvider>(
            builder: (context, assignmentProvider, taskProvider, _) {
              final progress = assignmentProvider.assignment?.progress ?? 0.0;
              final percentage = (progress * 100).round();
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text:
                          "Module: ${assignmentProvider.assignment?.moduleName ?? 'Loading...'}",
                      fontSize: 14,
                      color: AppColors.tertiary,
                    ),
                    SizedBox(height: 10),
                    CustomText(
                      text:
                          assignmentProvider.assignment?.title ?? 'Loading...',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 20),
                    CustomText(
                      text:
                          "Description: ${assignmentProvider.assignment?.details ?? 'Loading...'}",
                      fontSize: 16,
                    ),
                    SizedBox(height: 20),
                    CustomText(
                      text:
                          "Deadline: ${DateFormat('dd MMM yyyy').format(assignmentProvider.assignment?.deadline ?? DateTime.now())}",
                      fontSize: 14,
                      color: AppColors.tertiary,
                    ),
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        border: Border.all(
                          color: AppColors.border,
                          width: 1.25,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.center,

                              children: [
                                SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 10,
                                    backgroundColor: AppColors.border,
                                    value: progress,
                                  ),
                                ),
                                Text(
                                  '$percentage%',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            const CustomText(
                              text: "Overall Progress",
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(height: 10),
                            CustomText(
                              text:
                                  "You are in track with your assignment progress. Keep up the good work!",
                              fontSize: 14,
                              color: AppColors.tertiary,
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: _showEditAssignmentDialog,
                                  child: const Text('Edit'),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Add Task'),
                                          content: Form(
                                            key: _taskFormKey,
                                            child: TextFormField(
                                              controller: _taskTitleController,
                                              decoration: const InputDecoration(
                                                labelText: 'Task Title',
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.trim().isEmpty) {
                                                  return 'Please enter a task title';
                                                }

                                                return null;
                                              },
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                if (!mounted) return;
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancel'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                if (!_taskFormKey.currentState!
                                                    .validate()) {
                                                  return;
                                                }
                                                await _addTask();
                                                if (!mounted) return;
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Submit'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text('Add Task'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    const CustomText(
                      text: "Tasks",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 10),
                    if (taskProvider.isLoading)
                      Center(child: CircularProgressIndicator())
                    else if (taskProvider.tasks.isEmpty)
                      Center(child: Text("No tasks available"))
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: taskProvider.tasks.length,
                        itemBuilder: (context, index) {
                          final task = taskProvider.tasks[index];

                          return TaskCard(
                            taskName: task.taskTitle,
                            taskId: task.taskId,
                            isCompleted: task.isCompleted,
                            assignmentId: widget.assignmentId,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
