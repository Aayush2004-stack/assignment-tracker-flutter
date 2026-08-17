import 'dart:convert';

import 'package:assignment_tracker/model/user_model.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  static const _profileUrl = 'http://localhost:3000/api/auth/me';

  Future<UserModel> getProfile(String token) async {
    final response = await http.get(
      Uri.parse(_profileUrl),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    throw Exception('Unable to load profile: ${response.statusCode}');
  }
}
