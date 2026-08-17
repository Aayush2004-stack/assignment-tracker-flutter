import 'package:assignment_tracker/model/assignment_model.dart';
import 'package:assignment_tracker/services/assignment_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssignmentProvider extends ChangeNotifier {
  final List<AssignmentModel> _assignments = [];
  final List<AssignmentModel> _upcomingAssignments = [];
  final List<AssignmentModel> _selectedDateAssignments = [];
  final List<AssignmentModel> _moduleAssignments = [];
  AssignmentModel? _assignment;

  List<AssignmentModel> get assignments => _assignments;
  List<AssignmentModel> get upcomingAssignments => _upcomingAssignments;
  List<AssignmentModel> get selectedDateAssignments => _selectedDateAssignments;
  List<AssignmentModel> get moduleAssignments => _moduleAssignments;
  AssignmentModel? get assignment => _assignment;

  bool isLoading = false;

  Future<void> addAssignment(
    String title,
    String details,
    String givenDate,
    String dueDate,
    int moduleId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? '';
    try {
      await AssignmentService().createAssignment(
        title,
        details,
        givenDate,
        dueDate,
        moduleId,
        token,
      );

      await fetchAssignments();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> fetchModuleAssignments(int moduleId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    isLoading = true;
    notifyListeners();

    try {
      final remoteAssignments = await AssignmentService().getAssignmentsOfModule(moduleId,
        token!,
      );
      _moduleAssignments.clear();
      _moduleAssignments.addAll(remoteAssignments);
        
      
    } catch (e) {
      // Handle error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAssignmentDetails(int assignmentId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    isLoading = true;
    notifyListeners();

    try {
      final assignmentDetails = await AssignmentService().getAssignmentDetails(
        assignmentId,
        token!,
      );
      _assignment = assignmentDetails;
    } catch (e) {
      // Handle error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

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
          .take(2),
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
        remoteAssignments.where(
          (assignment) =>
              assignment.deadline.year == selectedDate.year &&
              assignment.deadline.month == selectedDate.month &&
              assignment.deadline.day == selectedDate.day,
        ),
      );
    } catch (e) {
      // Handle error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
