import 'package:flutter/material.dart';
import 'package:assignment_tracker/app/app_theme.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.color = AppColors.neutral,
    this.fontWeight = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
