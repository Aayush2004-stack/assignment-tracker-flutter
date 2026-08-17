import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:assignment_tracker/provider/module_provider.dart';
import 'package:assignment_tracker/widgets/module_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModulesScreen extends StatefulWidget {
  const ModulesScreen({super.key});

  @override
  State<ModulesScreen> createState() => _ModulesScreenState();
}

class _ModulesScreenState extends State<ModulesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _moduleNameController = TextEditingController();

  @override
  void dispose() {
    _moduleNameController.dispose();
    super.dispose();
  }

  Future<void> _addModule() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final moduleProvider = context.read<ModuleProvider>();
    await moduleProvider.addModule(_moduleNameController.text.trim());

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Module added successfully')));

    _moduleNameController.clear();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<ModuleProvider>().fetchModules();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ModuleProvider>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: "Academic Modules"),
                      SizedBox(height: 1),
                      CustomText(text: "Track your assignmenst"),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_circle_rounded,
                      size: 40,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Add Module'),
                            content: Form(
                              key: _formKey,
                              child: TextFormField(
                                controller: _moduleNameController,
                                decoration: InputDecoration(
                                  labelText: 'Module Name',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a module name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  await _addModule();
                                  Navigator.of(context).pop();
                                },
                                child: Text('Add'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              provider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : provider.modules.isEmpty
                  ? Center(child: Text("No modules available"))
                  : Expanded(
                      child: ListView.separated(
                        itemCount: provider.modules.length,
                        itemBuilder: (context, index) {
                          final module = provider.modules[index];
                          return ModuleCard(
                            moduleName: module.moduleName,
                            pendingAssignments: module.pendingAssignments,
                            moduleId: module.moduleId,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10);
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
