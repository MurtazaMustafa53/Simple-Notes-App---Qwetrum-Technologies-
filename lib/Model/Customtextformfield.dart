import 'package:flutter/material.dart';

class Customtextformfeild extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isPassword;
  final String? Function(String?)? validator;
  const Customtextformfeild({
    super.key,
    required this.controller,
    required this.hint,
    required this.label,
    this.isPassword = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
      ),
      validator: validator,
      obscureText: isPassword,
      controller: controller,
    );
  }
}
