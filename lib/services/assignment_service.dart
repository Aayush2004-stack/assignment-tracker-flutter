import 'dart:convert';

import 'package:assignment_tracker/model/assignment_model.dart';
import 'package:http/http.dart' as http;

class AssignmentService {
  final String baseUrl = 'http://localhost:3000/api/assignment';

  Future<List<AssignmentModel>> getAssignmentsOfModule(
    int moduleId,
    String token,
  ) async {
    final response = await http.get(
      Uri.parse('$baseUrl/module/$moduleId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => AssignmentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load assignments');
    }
  }

  Future<void> createAssignment(
    String title,
    String details,
    String givenDate,
    String dueDate,
    int moduleId,
    String token,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'title': title,
        'details': details,
        'givenDate': givenDate,
        'dueDate': dueDate,
        'moduleId': moduleId,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create assignment');
    }
  }

  Future<void> updateAssignment(
    int assignmentId,
    String title,
    String details,
    String givenDate,
    String dueDate,
    int moduleId,
    String token,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$assignmentId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'title': title,
        'details': details,
        'givenDate': givenDate,
        'dueDate': dueDate,
        'moduleId': moduleId,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create assignment');
    }
  }

  Future<List<AssignmentModel>> getAssignments(String token) async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => AssignmentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load assignments');
    }
  }

  Future<AssignmentModel> getAssignmentDetails(
    int assignmentId,
    String token,
  ) async {
    final String getUrl = '$baseUrl/$assignmentId';
    final response = await http.get(
      Uri.parse(getUrl),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return AssignmentModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load assignment details');
    }
  }
}
