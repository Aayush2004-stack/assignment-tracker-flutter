import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:assignment_tracker/widgets/assignment_card.dart';
import 'package:flutter/material.dart';

class ModuleAssignmentListScreen extends StatelessWidget {
  const ModuleAssignmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Module Assignments')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "Module Name"),
              SizedBox(height: 10),
              AssignmentCard(
                assignmentName: "Assignment 1",
                moduleName: "Module Name",
                dueDate: "2023-12-31",
                assignmentId: 1,
              ),
              SizedBox(height: 10),
              AssignmentCard(
                assignmentName: "Assignment 2",
                moduleName: "Module Name",
                dueDate: "2024-01-15",
                assignmentId: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}