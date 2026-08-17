import 'package:assignment_tracker/model/task_model.dart';
import 'package:assignment_tracker/services/task_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskProvider extends ChangeNotifier {
  bool isLoading = false;
  final List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  Future<void> fetchTasks({required int assignmentId}) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? '';
    isLoading = true;
    notifyListeners();
    try {
      final remoteTasks = await TaskService().fetchTasks(assignmentId, token);
      _tasks.clear();
      _tasks.addAll(remoteTasks);
      notifyListeners();
    } catch (e) {
      // Handle error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
