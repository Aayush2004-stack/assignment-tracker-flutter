import 'package:assignment_tracker/model/task_model.dart';
import 'package:assignment_tracker/services/task_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskProvider extends ChangeNotifier {
  bool isLoading = false;
  final List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  Future<void> addTask(int assignmentId, String title) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? '';
    try {
      await TaskService().createTask(assignmentId, title, token);

      await fetchTasks(assignmentId: assignmentId);
    } catch (e) {
      // Handle error
    }
  }

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

  Future<void> toggleTaskCompletion(int taskId) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? '';
    try {
      await TaskService().toggleTaskCompletion(taskId, token);
      // Update the local task list
      final index = _tasks.indexWhere((task) => task.taskId == taskId);
      if (index != -1) {
        _tasks[index].isCompleted = !_tasks[index].isCompleted;
        notifyListeners();
      }
    } catch (e) {
      // Handle error
    }
  }
}
