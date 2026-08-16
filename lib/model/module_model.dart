
import 'dart:convert';

List<ModuleModel> moduleModelFromJson(String str) => List<ModuleModel>.from(
  json.decode(str).map((x) => ModuleModel.fromJson(x)),
);

String moduleModelToJson(List<ModuleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModuleModel {
  int moduleId;
  String moduleName;
  String pendingAssignments;
  DateTime createdAt;
  DateTime updatedAt;

  ModuleModel({
    required this.moduleId,
    required this.moduleName,
    required this.pendingAssignments,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ModuleModel.fromJson(Map<String, dynamic> json) => ModuleModel(
    moduleId: json["module_id"],
    moduleName: json["module_name"],
    pendingAssignments: json["pending_assignments"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "module_id": moduleId,
    "module_name": moduleName,
    "pending_assignments": pendingAssignments,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
