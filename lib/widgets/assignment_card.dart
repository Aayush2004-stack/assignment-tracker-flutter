import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:flutter/material.dart';

class AssignmentCard extends StatelessWidget {
  const AssignmentCard({super.key});

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "Assignment Name"),
                Row(
                  children: [
                    Icon(Icons.calendar_month),
                    CustomText(text: " Due Date", fontSize: 16),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            CustomText(text: "Module Name"),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "Progress"),
                CustomText(text: "68%"),
              ],
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(value: 0.68),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
