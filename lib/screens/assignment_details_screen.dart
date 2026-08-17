import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:assignment_tracker/provider/assignment_provider.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _taskTitleController = TextEditingController();

  @override
  void dispose() {
    _taskTitleController.dispose();
    super.dispose();
  }

  Future<void> _addTask() async {
    if (!_formKey.currentState!.validate()) {
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
      appBar: AppBar(title: Text('Assignment Details')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer2<AssignmentProvider, TaskProvider>(
            builder: (context, assignmentProvider, taskProvider, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text:
                        "Module: ${assignmentProvider.assignment?.moduleName ?? 'Loading...'}",
                  ),
                  SizedBox(height: 10),
                  CustomText(
                    text: assignmentProvider.assignment?.title ?? 'Loading...',
                  ),
                  SizedBox(height: 20),
                  CustomText(
                    text:
                        "Description: ${assignmentProvider.assignment?.details ?? 'Loading...'}",
                  ),
                  SizedBox(height: 20),
                  CustomText(
                    text:
                        "Deadline: ${DateFormat('dd MMM yyyy').format(assignmentProvider.assignment?.deadline ?? DateTime.now())}",
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
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
                                  backgroundColor: Colors.grey[300],
                                  value: 0.68,
                                ),
                              ),

                              Text('${((0.68) * 100).round()}%'),
                            ],
                          ),
                          SizedBox(height: 10),
                          CustomText(text: "Overall Progress"),
                          SizedBox(height: 10),
                          CustomText(
                            text:
                                "You are in track with your assignment progress. Keep up the good work!",
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Edit'),
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
                                          key: _formKey,
                                          child: TextFormField(
                                            controller: _taskTitleController,
                                            decoration: InputDecoration(
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
                                              if (!_formKey.currentState!
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
                  CustomText(text: "Tasks"),
                  SizedBox(height: 10),
                  if (taskProvider.isLoading)
                    Center(child: CircularProgressIndicator())
                  else if (taskProvider.tasks.isEmpty)
                    Center(child: Text("No tasks available"))
                  else
                    Expanded(
                      child: ListView.separated(
                        itemCount: taskProvider.tasks.length,
                        itemBuilder: (context, index) {
                          final task = taskProvider.tasks[index];

                          return TaskCard(
                            taskName: task.taskTitle,
                            taskId: task.taskId,
                            isCompleted: task.isCompleted,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
