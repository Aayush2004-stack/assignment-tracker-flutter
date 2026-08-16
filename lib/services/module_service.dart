import 'dart:convert';

import 'package:assignment_tracker/model/module_model.dart';
import 'package:http/http.dart' as http;

class ModuleService {
  final String getModulesUrl = 'http://localhost:3000/api/module';

  Future<List<ModuleModel>> getModules(String token) async {
    final response = await http.get(
      Uri.parse(getModulesUrl),
      headers: {"Authorization": "Bearer $token",},
    );
    if (response.statusCode == 200) {
      List<dynamic> modulesJson = jsonDecode(response.body);
      return modulesJson.map((json) => ModuleModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load modules: ${response.statusCode}");
    }
  }
}
