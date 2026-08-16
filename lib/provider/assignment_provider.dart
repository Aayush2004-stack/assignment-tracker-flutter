import 'package:assignment_tracker/model/assignment_model.dart';
import 'package:assignment_tracker/services/assignment_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssignmentProvider extends ChangeNotifier {
  final List<AssignmentModel> _assignments = [];
  final List<AssignmentModel> _upcomingAssignments = [];
  final List<AssignmentModel> _selectedDateAssignments = [];

  List<AssignmentModel> get assignments => _assignments;
  List<AssignmentModel> get upcomingAssignments => _upcomingAssignments;
  List<AssignmentModel> get selectedDateAssignments => _selectedDateAssignments;

  bool isLoading = false;

  Future<void> fetchAssignments() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    isLoading = true;
    notifyListeners();

    try {
      final remoteAssignments = await AssignmentService().getAssignments(
        token!,
      );
      _assignments.clear();
      _assignments.addAll(remoteAssignments);
      getUpcomingAssignments(); // Update upcoming assignments after fetching all assignmentss
    } catch (e) {
      // Handle error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void getUpcomingAssignments() {
    final now = DateTime.now();
    _upcomingAssignments.clear();
    _upcomingAssignments.addAll(
      _assignments
          .where((assignment) => assignment.deadline.isAfter(now))
          .toList()
          .take(1),
    );
  }

  Future<void> getAssignmentsByDate(DateTime selectedDate) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    isLoading = true;
    notifyListeners();

    try {
      final remoteAssignments = await AssignmentService().getAssignments(
        token!,
      );
      _selectedDateAssignments.clear();
      _selectedDateAssignments.addAll(
        remoteAssignments.where((assignment) =>
            assignment.deadline.year == selectedDate.year &&
            assignment.deadline.month == selectedDate.month &&
            assignment.deadline.day == selectedDate.day),
      );
    } catch (e) {
      // Handle error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
