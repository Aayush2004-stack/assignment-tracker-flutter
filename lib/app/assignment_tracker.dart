import 'package:assignment_tracker/screens/login_screen.dart';
import 'package:flutter/material.dart';

class AssignmentTracker extends StatelessWidget {
  const AssignmentTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assignment Tracker',
      home: LoginScreen()
    );
  }
}
