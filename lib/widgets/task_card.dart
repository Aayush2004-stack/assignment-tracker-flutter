import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:assignment_tracker/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskCard extends StatelessWidget {
  final String taskName;
  final int taskId;
  final bool isCompleted;
  const TaskCard({
    super.key,
    required this.taskName,
    required this.taskId,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    isCompleted ? Icons.check_circle : Icons.circle_outlined,
                  ),
                  onPressed: () {
                    context.read<TaskProvider>().toggleTaskCompletion(taskId);
                  },
                ),
                SizedBox(width: 10),
                Text(
                  taskName,
                  style: TextStyle(
                    fontSize: 16,

                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
