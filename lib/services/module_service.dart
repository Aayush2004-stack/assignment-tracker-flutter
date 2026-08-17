import 'dart:convert';

import 'package:assignment_tracker/model/module_model.dart';
import 'package:http/http.dart' as http;

class ModuleService {
  final String baseUrl = 'http://localhost:3000/api/module';

  Future<void> createModule(String name, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"moduleName": name}),
    );

    if (response.statusCode != 201) {
      throw Exception("Failed to create module: ${response.statusCode}");
    }
  }

  Future<List<ModuleModel>> getModules(String token) async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200) {
      List<dynamic> modulesJson = jsonDecode(response.body);
      return modulesJson.map((json) => ModuleModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load modules: ${response.statusCode}");
    }
  }
}
