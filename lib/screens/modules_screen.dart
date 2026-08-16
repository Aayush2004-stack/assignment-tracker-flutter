import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:assignment_tracker/widgets/module_card.dart';
import 'package:flutter/material.dart';

class ModulesScreen extends StatefulWidget {
  const ModulesScreen({super.key});

  @override
  State<ModulesScreen> createState() => _ModulesScreenState();
}

class _ModulesScreenState extends State<ModulesScreen> {
  @override
  Widget build(BuildContext context) {
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
              ModuleCard(),
              SizedBox(height: 20),
              ModuleCard(),
              SizedBox(height: 20),
              ModuleCard(),
            ],
          ),
        ),
      ),
    );
  }
}
