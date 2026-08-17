import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:assignment_tracker/app/app_theme.dart';
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
          color: AppColors.surface,
          border: Border.all(color: AppColors.border, width: 1.25),
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
                  Expanded(
                    child: CustomText(
                      text: assignmentName,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        size: 18,
                        color: AppColors.tertiary,
                      ),
                      const SizedBox(width: 4),
                      CustomText(
                        text: dueDate,
                        fontSize: 13,
                        color: AppColors.tertiary,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              CustomText(
                text: moduleName,
                fontSize: 14,
                color: AppColors.tertiary,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "Progress",
                    fontSize: 13,
                    color: AppColors.tertiary,
                  ),
                  const CustomText(
                    text: "68%",
                    fontSize: 13,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
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
