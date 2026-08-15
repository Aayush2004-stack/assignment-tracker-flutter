import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  const CustomTextFormField({
    super.key,
    required this.icon,
    required this.hintText,
    this.isPassword = false,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hint: Text(hintText, style: TextStyle(fontSize: 16)),
        suffixIcon: Icon(icon, size: 20),
      ),
    );
  }
}
