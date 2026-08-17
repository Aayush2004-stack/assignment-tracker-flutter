import 'package:assignment_tracker/model/task_model.dart';
import 'package:http/http.dart' as http;

class TaskService {
  final String baseUrl = 'http://localhost:3000/api/task';

  Future<void> createTask(int assignmentId, String title, String token) async {
    final String postUrl = '$baseUrl/add';
    final response = await http.post(
      Uri.parse(postUrl),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token',
      },
      body: '{"title": "$title", "assignmentId": "$assignmentId"}',
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create task');
    }
  }

  Future<void> updateTask(int taskId, String title, String token) async {
    final String updateUrl = '$baseUrl/$taskId';
    final response = await http.put(
      Uri.parse(updateUrl),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token',
      },
      body: '{"title": "$title"}',
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(int taskId, String token) async {
    final String deleteUrl = '$baseUrl/$taskId';
    final response = await http.delete(
      Uri.parse(deleteUrl),
      headers: {
        'authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }

  Future<List<TaskModel>> fetchTasks(int assignmentId, String token) async {
    final String getUrl = '$baseUrl/assignment/$assignmentId';
    final response = await http.get(
      Uri.parse(getUrl),
      headers: {
        'authorization': 'Bearer $token', //
      },
    );

    if (response.statusCode == 200) {
      return taskModelFromJson(response.body);
    } else {
      throw Exception('Failed to load tasks');
    }
  }
  Future<void> toggleTaskCompletion(int taskId, String token) async {
    final String updateUrl = '$baseUrl/toggle-completion/$taskId';
    final response = await http.patch(
      Uri.parse(updateUrl),
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update task completion');
    }
  }

  
}
