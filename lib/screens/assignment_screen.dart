import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:assignment_tracker/model/module_model.dart';
import 'package:assignment_tracker/provider/assignment_provider.dart';
import 'package:assignment_tracker/provider/module_provider.dart';
import 'package:assignment_tracker/widgets/assignment_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _taskTitleController = TextEditingController();
  final _taskDetailController = TextEditingController();
  final _givenDateController = TextEditingController();
  final _dueDateController = TextEditingController();
  int? _selectedModule;

  @override
  void dispose() {
    _taskTitleController.dispose();
    _taskDetailController.dispose();
    _givenDateController.dispose();
    _dueDateController.dispose();

    super.dispose();
  }

  Future<void> _addAssignment() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final assignmentProvider = context.read<AssignmentProvider>();
    await assignmentProvider.addAssignment(
      _taskTitleController.text.trim(),
      _taskDetailController.text.trim(),
      _givenDateController.text.trim(),

      _dueDateController.text.trim(),
      _selectedModule!,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Assignment added successfully')));

    _taskTitleController.clear();
    _taskDetailController.clear();
    _givenDateController.clear();
    _dueDateController.clear();
    setState(() {
      _selectedModule = null;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<AssignmentProvider>().fetchAssignments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final moduleProvider = context.watch<ModuleProvider>();
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
                      CustomText(text: "Your Assignmnets"),
                      SizedBox(height: 1),
                      CustomText(text: "Track your progress"),
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
                            title: Text('Add Assignment'),
                            content: Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: _taskTitleController,
                                      decoration: InputDecoration(
                                        labelText: 'Title',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a title';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: _taskDetailController,
                                      decoration: InputDecoration(
                                        labelText: 'Details',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter details';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: _givenDateController,
                                      decoration: InputDecoration(
                                        labelText: 'Given Date (YYYY-MM-DD)',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a given date';
                                        } else if (!RegExp(
                                          r'^\d{4}-\d{2}-\d{2}$',
                                        ).hasMatch(value)) {
                                          return 'Please enter a valid date in YYYY-MM-DD format';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: _dueDateController,
                                      decoration: InputDecoration(
                                        labelText: 'Due Date (YYYY-MM-DD)',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a due date';
                                        } else if (!RegExp(
                                          r'^\d{4}-\d{2}-\d{2}$',
                                        ).hasMatch(value)) {
                                          return 'Please enter a valid date in YYYY-MM-DD format';
                                        }
                                        return null;
                                      },
                                    ),
                                    DropdownButtonFormField(
                                      hint: Text("Select a module"),
                                      items: moduleProvider.modules.map((
                                        module,
                                      ) {
                                        return DropdownMenuItem(
                                          value: module.moduleId,
                                          child: Text(module.moduleName),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedModule = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null) {
                                          return "Please select a module";
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
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
                                  await _addAssignment();
                                  if (!mounted) return;
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
              Consumer<AssignmentProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (provider.assignments.isEmpty) {
                    return Center(child: Text("No assignments available"));
                  } else {
                    return Expanded(
                      child: ListView.separated(
                        itemCount: provider.assignments.length,
                        itemBuilder: (context, index) {
                          final assignment = provider.assignments[index];
                          return AssignmentCard(
                            assignmentName: assignment.title,
                            assignmentId: assignment.assignmentId,
                            moduleName: assignment.moduleName,
                            dueDate: DateFormat(
                              'dd MMM yyyy',
                            ).format(assignment.deadline),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
