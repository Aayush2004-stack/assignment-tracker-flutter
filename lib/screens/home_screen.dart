import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:assignment_tracker/app/app_theme.dart';
import 'package:assignment_tracker/provider/assignment_provider.dart';
import 'package:assignment_tracker/provider/profile_provider.dart';
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
      context.read<AssignmentProvider>().fetchAssignments();
      context.read<ProfileProvider>().fetchProfile();
    });
  }

  String _greetingForCurrentTime() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    if (hour < 21) return 'Good evening';
    return 'Good night';
  }

  String _firstName(String? fullName) {
    final names = fullName?.trim().split(RegExp(r'\s+')) ?? [];
    return names.isEmpty ? '' : names.first;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AssignmentProvider>();
    final firstName = _firstName(
      context.watch<ProfileProvider>().user?.fullName,
    );
    final greeting = _greetingForCurrentTime();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: firstName.isEmpty ? greeting : '$greeting, $firstName',
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 30),
              AssignmentSummaryCard(
                title: "Due today",
                summaryNumber: provider.dueTodayAssignments.length.toString(),
                cardColor: AppColors.secondary,
              ),
              SizedBox(height: 20),
              AssignmentSummaryCard(
                title: "Due in this week",
                summaryNumber: provider.dueThisWeekAssignments.length
                    .toString(),
                cardColor: const Color(0xFFE9E7F6),
              ),
              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "Upcoming",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  const CustomText(
                    text: "View all",
                    fontSize: 14,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
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
                            totalTasks: assignment.totalTasks,
                            completedTasks: assignment.completedTasks,
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
