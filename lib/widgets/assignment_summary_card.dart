import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:assignment_tracker/app/app_theme.dart';
import 'package:flutter/material.dart';

class AssignmentSummaryCard extends StatelessWidget {
  final String title;
  final String summaryNumber;
  final Color cardColor;
  const AssignmentSummaryCard({
    super.key,
    required this.title,
    required this.summaryNumber,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(color: AppColors.border, width: 1.25),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: title, fontSize: 14, color: AppColors.tertiary),
            SizedBox(height: 30),
            CustomText(
              text: summaryNumber,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
