import 'dart:convert';

import 'package:assignment_tracker/model/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String loginUrl="http://localhost:3000/api/auth/login";

  Future<AuthTokens> login(String email, String password) async{
    final response = await http.post(
      Uri.parse(loginUrl),
      headers:{"Content-Type":"application/json"},
      body:jsonEncode({"email":email,"password":password})
    );
    if(response.statusCode==200 || response.statusCode==201){
      return AuthTokens.fromJson(jsonDecode(response.body));
    }
    if(response.statusCode==401){
      throw Exception("Invalid email or password");
    }
    throw Exception("Login failed: ${response.statusCode}");
  }


}