import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:flutter/material.dart';

class AssignmentSummaryCard extends StatelessWidget {

  final String title;
  final String summaryNumber;
  final Color cardColor;
  const AssignmentSummaryCard({super.key, required this.title, required this.summaryNumber, required this.cardColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: title),
            SizedBox(height: 30),
            CustomText(text: summaryNumber),
          ],
        ),
      ),
    );
  }
}
