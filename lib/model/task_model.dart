// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

List<TaskModel> taskModelFromJson(String str) =>
    List<TaskModel>.from(json.decode(str).map((x) => TaskModel.fromJson(x)));

String taskModelToJson(List<TaskModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TaskModel {
  int taskId;
  int assignmentId;
  String taskTitle;
  bool isCompleted;
  DateTime createdAt;
  DateTime updatedAt;

  TaskModel({
    required this.taskId,
    required this.assignmentId,
    required this.taskTitle,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    taskId: json["task_id"],
    assignmentId: json["assignment_id"],
    taskTitle: json["task_title"],
    isCompleted: json["is_completed"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "task_id": taskId,
    "assignment_id": assignmentId,
    "task_title": taskTitle,
    "is_completed": isCompleted,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
