import 'package:assignment_tracker/model/assignment_model.dart';
import 'package:assignment_tracker/services/assignment_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssignmentProvider extends ChangeNotifier {
  final List<AssignmentModel> _assignments = [];
  final List<AssignmentModel> _upcomingAssignments = [];
  final List<AssignmentModel> _dueTodayAssignments = [];
  final List<AssignmentModel> _dueThisWeekAssignments = [];
  final List<AssignmentModel> _selectedDateAssignments = [];
  final List<AssignmentModel> _moduleAssignments = [];
  AssignmentModel? _assignment;

  List<AssignmentModel> get assignments => _assignments;
  List<AssignmentModel> get upcomingAssignments => _upcomingAssignments;
  List<AssignmentModel> get dueTodayAssignments => _dueTodayAssignments;
  List<AssignmentModel> get dueThisWeekAssignments => _dueThisWeekAssignments;
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

  Future<void> updateAssignment(
    int assignmentId,
    String title,
    String details,
    String givenDate,
    String dueDate,
    int moduleId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? '';
    try {
      await AssignmentService().updateAssignment(
        assignmentId,
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
      final remoteAssignments = await AssignmentService()
          .getAssignmentsOfModule(moduleId, token!);
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
    final startOfToday = DateTime(now.year, now.month, now.day);
    final endOfWeek = startOfToday.add(
      Duration(days: 6 - startOfToday.weekday),
    );
    final startOfNextDay = startOfToday.add(const Duration(days: 1));

    _dueTodayAssignments
      ..clear()
      ..addAll(
        _assignments.where(
          (assignment) => _isSameDate(assignment.deadline, startOfToday),
        ),
      );
    _dueThisWeekAssignments
      ..clear()
      ..addAll(
        _assignments.where(
          (assignment) =>
              !assignment.deadline.isBefore(startOfToday) &&
              assignment.deadline.isBefore(
                endOfWeek.add(const Duration(days: 1)),
              ),
        ),
      );
    final upcoming =
        _assignments
            .where(
              (assignment) => !assignment.deadline.isBefore(startOfNextDay),
            )
            .toList()
          ..sort((first, second) => first.deadline.compareTo(second.deadline));
    _upcomingAssignments
      ..clear()
      ..addAll(upcoming.take(2));
  }

  void updateCurrentAssignmentProgress({
    required int assignmentId,
    required int totalTasks,
    required int completedTasks,
  }) {
    void update(List<AssignmentModel> items) {
      for (final item in items) {
        if (item.assignmentId == assignmentId) {
          item.totalTasks = totalTasks.toString();
          item.completedTasks = completedTasks.toString();
        }
      }
    }

    if (_assignment?.assignmentId == assignmentId) {
      _assignment!.totalTasks = totalTasks.toString();
      _assignment!.completedTasks = completedTasks.toString();
    }
    update(_assignments);
    update(_upcomingAssignments);
    update(_dueTodayAssignments);
    update(_dueThisWeekAssignments);
    update(_selectedDateAssignments);
    update(_moduleAssignments);
    notifyListeners();
  }

  bool _isSameDate(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
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
