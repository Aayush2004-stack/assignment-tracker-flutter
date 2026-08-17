import 'package:assignment_tracker/provider/task_provider.dart';
import 'package:assignment_tracker/app/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskCard extends StatelessWidget {
  final String taskName;
  final int taskId;
  final bool isCompleted;
  final int assignmentId;
  const TaskCard({
    super.key,
    required this.taskName,
    required this.taskId,
    required this.isCompleted,
    required this.assignmentId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border, width: 1.25),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isCompleted
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                      ),
                      color: isCompleted
                          ? AppColors.primary
                          : AppColors.tertiary,
                      onPressed: () {
                        context.read<TaskProvider>().toggleTaskCompletion(
                          taskId,
                        );
                      },
                    ),
                    SizedBox(width: 10),
                    Text(
                      taskName,
                      style: TextStyle(
                        fontSize: 16,
                        color: isCompleted
                            ? AppColors.tertiary
                            : AppColors.neutral,
                        fontWeight: FontWeight.w500,

                        decoration: isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: AppColors.primary,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            String updatedTaskName = taskName;
                            return AlertDialog(
                              title: Text("Edit Task"),
                              content: TextField(
                                onChanged: (value) {
                                  updatedTaskName = value;
                                },
                                controller: TextEditingController(
                                  text: taskName,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Enter new task name",
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text("Update"),
                                  onPressed: () {
                                    context.read<TaskProvider>().updateTask(
                                      taskId,
                                      updatedTaskName,
                                      assignmentId,
                                    );
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: AppColors.tertiary,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Delete Task"),
                              content: Text(
                                "Are you sure you want to delete this task?",
                              ),
                              actions: [
                                TextButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text("Delete"),
                                  onPressed: () {
                                    context.read<TaskProvider>().deleteTask(
                                      taskId,
                                      assignmentId,
                                    );
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
