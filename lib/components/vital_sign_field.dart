import 'package:flutter/material.dart';

class VitalSignField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final String suffix;
  final String? Function(String?) validator;

  const VitalSignField({
    required this.controller,
    required this.hint,
    required this.icon,
    required this.suffix,
    required this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixText: suffix,
      ),
      keyboardType: TextInputType.number,
      validator: validator,
    );
  }
}