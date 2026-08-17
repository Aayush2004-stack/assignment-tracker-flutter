import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:assignment_tracker/provider/assignment_provider.dart';
import 'package:assignment_tracker/widgets/assignment_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ModuleAssignmentListScreen extends StatelessWidget {
  final int moduleId;
  final String moduleName;
  const ModuleAssignmentListScreen({
    super.key,
    required this.moduleId,
    required this.moduleName,
  });

  @override
  Widget build(BuildContext context) {
    context.read<AssignmentProvider>().fetchModuleAssignments(moduleId);

    return Scaffold(
      appBar: AppBar(title: Text('Module Assignments')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "Assignments for module: $moduleName"),
              SizedBox(height: 20),

              Expanded(
                child: Consumer<AssignmentProvider>(
                  builder: (context, assignmentProvider, _) {
                    if (assignmentProvider.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (assignmentProvider.moduleAssignments.isEmpty) {
                      return Center(
                        child: Text('No assignments found for module:'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: assignmentProvider.moduleAssignments.length,
                        itemBuilder: (context, index) {
                          final assignment =
                              assignmentProvider.moduleAssignments[index];
                          return AssignmentCard(
                            assignmentId: assignment.assignmentId,
                            assignmentName: assignment.title,
                            moduleName: assignment.moduleName,
                            dueDate: DateFormat(
                              'dd MMM yyyy',
                            ).format(assignment.deadline).toString(),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
