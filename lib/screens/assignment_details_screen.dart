import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:assignment_tracker/widgets/task_card.dart';
import 'package:flutter/material.dart';

class AssignmentDetailsScreen extends StatefulWidget {
  final int assignmentId;
  const AssignmentDetailsScreen({super.key, required this.assignmentId});

  @override
  State<AssignmentDetailsScreen> createState() =>
      _AssignmentDetailsScreenState();
}

class _AssignmentDetailsScreenState extends State<AssignmentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Assignment Details')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "Module: Module Name"),
              SizedBox(height: 10),
              CustomText(text: "Assignment Name"),
              SizedBox(height: 20),
              CustomText(
                text: "Description: This is a sample assignment description.",
              ),
              SizedBox(height: 20),
              CustomText(text: "Deadline: 2023-12-31"),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.center,

                        children: [
                          SizedBox(
                            width: 60,

                            height: 60,

                            child: CircularProgressIndicator(
                              strokeWidth: 10,
                              backgroundColor: Colors.grey[300],
                              value: 0.68,
                            ),
                          ),

                          Text('${((0.68) * 100).round()}%'),
                        ],
                      ),
                      SizedBox(height: 10),
                      CustomText(text: "Overall Progress"),
                      SizedBox(height: 10),
                      CustomText(
                        text:
                            "You are in track with your assignment progress. Keep up the good work!",
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(onPressed: () {}, child: Text('Edit')),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text('Add Task'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              CustomText(text: "Tasks"),
              SizedBox(height: 10),
              TaskCard(),
              SizedBox(height: 10),
              TaskCard(),
              SizedBox(height: 10),
              TaskCard(),
            ],
          ),
        ),
      ),
    );
  }
}
