import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:assignment_tracker/screens/module_assignment_list_screen.dart';
import 'package:flutter/material.dart';

class ModuleCard extends StatelessWidget {
  final String moduleName;
  final String pendingAssignments;
  final int moduleId;
  const ModuleCard({
    super.key,

    required this.moduleName,
    required this.pendingAssignments,
    required this.moduleId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the module assignment list screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ModuleAssignmentListScreen(moduleId: moduleId, moduleName: moduleName),
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
                children: [Icon(Icons.book), Icon(Icons.more_vert)],
              ),
              SizedBox(height: 20),
              CustomText(text: moduleName),
              SizedBox(height: 5),
              CustomText(
                text: int.tryParse(pendingAssignments)! > 1
                    ? "$pendingAssignments Assignments pending"
                    : "$pendingAssignments Assignment pending",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
