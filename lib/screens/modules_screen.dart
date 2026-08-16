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
                  Icon(Icons.add_circle_rounded, size: 40, color: Colors.grey),
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
