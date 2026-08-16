import 'package:assignment_tracker/custom/custom_text.dart';
import 'package:flutter/material.dart';

class ModuleCard extends StatelessWidget {
  const ModuleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Icon(Icons.book), Icon(Icons.more_vert)],
            ),
            SizedBox(height: 20),
            CustomText(text: "Module Name"),
            SizedBox(height: 5),
            CustomText(text: "1 Assignment pending"),
          ],
        ),
      ),
    );
  }
}
