import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:flutter/material.dart';

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
                    // Handle task completion
                  },
                ),
                SizedBox(width: 10),
                CustomText(text: taskName),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
