import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:assignment_tracker/provider/assignment_provider.dart';
import 'package:assignment_tracker/widgets/assignment_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<AssignmentProvider>().fetchAssignments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: "Your Assignmnets"),
                      SizedBox(height: 1),
                      CustomText(text: "Track your progress"),
                    ],
                  ),
                  Icon(Icons.add_circle_rounded, size: 40, color: Colors.grey),
                ],
              ),
              SizedBox(height: 20),
              Consumer<AssignmentProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (provider.assignments.isEmpty) {
                    return Center(child: Text("No assignments available"));
                  } else {
                    return Expanded(
                      child: ListView.separated(
                        itemCount: provider.assignments.length,
                        itemBuilder: (context, index) {
                          final assignment =
                              provider.assignments[index];
                          return AssignmentCard(
                            assignmentName: assignment.title,
                            moduleName: assignment.moduleName,
                            dueDate: DateFormat(
                              'dd MMM yyyy',
                            ).format(assignment.deadline),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
