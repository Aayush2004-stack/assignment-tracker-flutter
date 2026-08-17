import 'dart:convert';

List<AssignmentModel> assignmentModelFromJson(String str) =>
    List<AssignmentModel>.from(
      json.decode(str).map((x) => AssignmentModel.fromJson(x)),
    );

String assignmentModelToJson(List<AssignmentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AssignmentModel {
  int moduleId;
  String moduleName;
  int assignmentId;
  String title;
  String details;
  DateTime givenDate;
  DateTime deadline;
  DateTime createdAt;
  DateTime updatedAt;
  String totalTasks;
  String completedTasks;

  int get totalTasksCount => int.tryParse(totalTasks) ?? 0;
  int get completedTasksCount => int.tryParse(completedTasks) ?? 0;
  double get progress => totalTasksCount == 0
      ? 0
      : (completedTasksCount / totalTasksCount).clamp(0.0, 1.0);

  AssignmentModel({
    required this.moduleId,
    required this.moduleName,
    required this.assignmentId,
    required this.title,
    required this.details,
    required this.givenDate,
    required this.deadline,
    required this.createdAt,
    required this.updatedAt,
    required this.totalTasks,
    required this.completedTasks,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) =>
      AssignmentModel(
        moduleId: json["module_id"],
        moduleName: json["module_name"],
        assignmentId: json["assignment_id"],
        title: json["title"],
        details: json["details"],
        givenDate: DateTime.parse(json["given_date"]),
        deadline: DateTime.parse(json["deadline"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        totalTasks: json["total_tasks"]?.toString() ?? '0',
        completedTasks: json["completed_tasks"]?.toString() ?? '0',
      );

  Map<String, dynamic> toJson() => {
    "module_id": moduleId,
    "module_name": moduleName,
    "assignment_id": assignmentId,
    "title": title,
    "details": details,
    "given_date": givenDate.toIso8601String(),
    "deadline": deadline.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
