import 'package:assignment_tracker/model/user_model.dart';
import 'package:assignment_tracker/services/profile_service.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider({ProfileService? profileService})
    : _profileService = profileService ?? ProfileService();

  final ProfileService _profileService;

  UserModel? user;
  bool isLoading = false;
  bool isUploading = false;
  String? errorMessage;

  Future<void> fetchProfile() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');
      if (token == null || token.isEmpty) {
        throw Exception('You are not logged in.');
      }
      user = await _profileService.getProfile(token);
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> uploadProfileImage(XFile image) async {
    isUploading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token');
      if (token == null || token.isEmpty) {
        throw Exception('You are not logged in.');
      }
      await _profileService.uploadProfileImage(image.path, token);
      user = await _profileService.getProfile(token);
      return true;
    } catch (error) {
      errorMessage = error.toString();
      return false;
    } finally {
      isUploading = false;
      notifyListeners();
    }
  }

  void clearProfile() {
    user = null;
    errorMessage = null;
    notifyListeners();
  }
}
