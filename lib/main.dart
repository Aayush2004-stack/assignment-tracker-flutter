import 'package:assignment_tracker/app/assignment_tracker.dart';
import 'package:assignment_tracker/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_)=>AuthProvider())],
    child: const AssignmentTracker()));
}
