import 'dart:convert';

import 'package:assignment_tracker/model/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String loginUrl = "http://localhost:3000/api/auth/login";
  static const String registerUrl = 'http://localhost:3000/api/auth/register';

  Future<AuthTokens> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return AuthTokens.fromJson(jsonDecode(response.body));
    }
    if (response.statusCode == 401) {
      throw Exception("Invalid email or password");
    }
    throw Exception("Login failed: ${response.statusCode}");
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await http.post(
      Uri.parse(registerUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'fullName': fullName,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'userImg': 'a',
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Registration failed: ${response.statusCode}');
    }
  }
}
