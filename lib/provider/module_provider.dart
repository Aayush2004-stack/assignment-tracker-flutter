import 'package:assignment_tracker/model/module_model.dart';
import 'package:assignment_tracker/services/module_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModuleProvider extends ChangeNotifier {
  final List<ModuleModel> _modules = [];

  List<ModuleModel> get modules => _modules;

  bool isLoading = false;

  Future<void> fetchModules() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    isLoading = true;
    notifyListeners();

    try {
      final remoteModules = await ModuleService().getModules(token!);
      _modules.clear();
      _modules.addAll(remoteModules);
    } catch (e) {
      // Handle error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addModule(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      await ModuleService().createModule(name, token!);
      await fetchModules();
    } catch (e) {
      // Handle error
    }
  }
}
