import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:assignment_tracker/widgets/assignment_summary_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              Container(
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
                        children: [
                          CustomText(text: "Assignment Name"),
                          Row(
                            children: [
                              Icon(Icons.calendar_month),
                              CustomText(text: " Due Date", fontSize: 16),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      CustomText(text: "Module Name"),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(text: "Progress"),
                          CustomText(text: "68%"),
                        ],
                      ),
                      SizedBox(height: 10),
                      LinearProgressIndicator(value: 0.68),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
