import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:assignment_tracker/screens/assignment_details_screen.dart';
import 'package:flutter/material.dart';

class AssignmentCard extends StatelessWidget {
  final String assignmentName;
  final String moduleName;
  final String dueDate;
  final int assignmentId;
  const AssignmentCard({
    super.key,
    required this.assignmentName,
    required this.moduleName,
    required this.dueDate,
    required this.assignmentId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AssignmentDetailsScreen(assignmentId: assignmentId),
          ),
        );
      },
      child: Container(
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
                  CustomText(text: assignmentName),
                  Row(
                    children: [
                      Icon(Icons.calendar_month),
                      CustomText(text: dueDate, fontSize: 16),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              CustomText(text: moduleName),
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
      ),
    );
  }
}
