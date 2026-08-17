import 'dart:convert';

import 'package:assignment_tracker/model/user_model.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  static const _profileUrl = 'http://localhost:3000/api/auth/me';
  static const _uploadUrl = 'http://localhost:3000/api/images/profile-image';

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

  Future<void> uploadProfileImage(String imagePath, String token) async {
    final request = http.MultipartRequest('POST', Uri.parse(_uploadUrl));
    request.headers['Authorization'] = 'Bearer $token';
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imagePath,
        contentType: http.MediaType('image', 'jpeg'),
      ),
    );

    final response = await request.send();
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Unable to upload profile image: ${response.statusCode}');
    }
  }
}
