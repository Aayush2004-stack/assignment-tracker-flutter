import 'package:assignment_tracker/app/assignment_tracker.dart';
import 'package:assignment_tracker/provider/assignment_provider.dart';
import 'package:assignment_tracker/provider/auth_provider.dart';
import 'package:assignment_tracker/provider/module_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ModuleProvider()),
        ChangeNotifierProvider(create: (_) => AssignmentProvider()),
      ],
      child: const AssignmentTracker(),
    ),
  );
}
