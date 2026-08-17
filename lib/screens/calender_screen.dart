import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:assignment_tracker/app/app_theme.dart';
import 'package:assignment_tracker/provider/assignment_provider.dart';
import 'package:assignment_tracker/widgets/assignment_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<AssignmentProvider>().getAssignmentsByDate(selectedDate);
    });
  }

  DateTime selectedDate = DateTime.now();
  List<DateTime> get weekDates {
    final daysFromSunday = selectedDate.weekday % 7;
    final startOfWeek = selectedDate.subtract(Duration(days: daysFromSunday));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
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
                      CustomText(
                        text: DateFormat('MMMM').format(selectedDate),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      CustomText(
                        text: DateFormat('EEEE,  d').format(selectedDate),
                        fontSize: 14,
                        color: AppColors.tertiary,
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.calendar_month_outlined,
                    color: AppColors.primary,
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildWeekCalendar(),
              SizedBox(height: 20),
              CustomText(
                text: DateTime.now().day == selectedDate.day
                    ? "Today's Assignments"
                    : "Assignments on ${DateFormat('EEEE, d').format(selectedDate)}",
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),

              SizedBox(height: 20),
              Consumer<AssignmentProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (provider.selectedDateAssignments.isEmpty) {
                    return Center(child: Text("No assignments available"));
                  } else {
                    return Expanded(
                      child: ListView.separated(
                        itemCount: provider.selectedDateAssignments.length,
                        itemBuilder: (context, index) {
                          final assignment =
                              provider.selectedDateAssignments[index];
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

  Widget _buildWeekCalendar() {
    return Container(
      padding: const EdgeInsets.all(5),

      decoration: BoxDecoration(
        color: AppColors.surface,

        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: AppColors.border, width: 1.25),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: weekDates.map((date) {
          final isSelected =
              date.year == selectedDate.year &&
              date.month == selectedDate.month &&
              date.day == selectedDate.day;

          return _buildDateItem(date: date, isSelected: isSelected);
        }).toList(),
      ),
    );
  }

  Widget _buildDateItem({required DateTime date, required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDate = date;
        });
        context.read<AssignmentProvider>().getAssignmentsByDate(selectedDate);
      },

      child: Container(
        width: 48,

        height: 76,

        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,

          borderRadius: BorderRadius.circular(12),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(
              DateFormat('E').format(date).substring(0, 1),

              style: TextStyle(
                fontSize: 14,

                fontWeight: FontWeight.w600,

                color: isSelected ? Colors.white : AppColors.tertiary,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              DateFormat('d').format(date),

              style: TextStyle(
                fontSize: 20,

                fontWeight: FontWeight.w600,

                color: isSelected ? Colors.white : AppColors.neutral,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
