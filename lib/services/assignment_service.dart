import 'dart:convert';

import 'package:assignment_tracker/model/assignment_model.dart';
import 'package:http/http.dart' as http;

class AssignmentService {
  final String getAssignmentsUrl = 'http://localhost:3000/api/assignment';

  Future<List<AssignmentModel>> getAssignments(String token) async {
    final response = await http.get(
      Uri.parse(getAssignmentsUrl),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => AssignmentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load assignments');
    }
  }
}
