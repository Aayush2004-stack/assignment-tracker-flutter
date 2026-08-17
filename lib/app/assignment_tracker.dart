import 'package:assignment_tracker/auth/auth_gate.dart';
import 'package:assignment_tracker/app/app_theme.dart';
import 'package:flutter/material.dart';

class AssignmentTracker extends StatelessWidget {
  const AssignmentTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assignment Tracker',
      theme: AppTheme.light,
      home: const AuthGate(),
    );
  }
}
