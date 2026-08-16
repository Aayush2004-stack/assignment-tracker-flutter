import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:assignment_tracker/provider/assignment_provider.dart';
import 'package:assignment_tracker/widgets/assignment_card.dart';
import 'package:assignment_tracker/widgets/assignment_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<AssignmentProvider>().getUpcomingAssignments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AssignmentProvider>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "Good evening, Machoos"),
              SizedBox(height: 30),
              AssignmentSummaryCard(
                title: "Due today",
                summaryNumber: "5",
                cardColor: const Color.fromARGB(62, 33, 149, 243),
              ),
              SizedBox(height: 20),
              AssignmentSummaryCard(
                title: "Due in this week",
                summaryNumber: "10",
                cardColor: const Color.fromARGB(61, 243, 149, 33),
              ),
              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: "Upcoming"),
                  CustomText(text: "View all", fontSize: 16),
                ],
              ),
              SizedBox(height: 15),
              provider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : provider.upcomingAssignments.isEmpty
                  ? Center(child: Text("No assignments available"))
                  : Expanded(
                      child: ListView.separated(
                        itemCount: provider.upcomingAssignments.length,
                        itemBuilder: (context, index) {
                          final assignment =
                              provider.upcomingAssignments[index];

                          return AssignmentCard(
                            assignmentName: assignment.title,
                            assignmentId: assignment.assignmentId,
                            moduleName: assignment.moduleName,
                            dueDate: DateFormat(
                              'dd MMM yyyy',
                            ).format(assignment.deadline),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
