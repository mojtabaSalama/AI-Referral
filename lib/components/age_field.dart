import 'package:flutter/material.dart';

class AgeField extends StatelessWidget {
  final TextEditingController controller;
  const AgeField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Age *',
        prefixIcon: Icon(Icons.calendar_today),
        suffixText: 'years',
      ),
      keyboardType: TextInputType.number,
      validator: (v) {
        if (v == null || v.isEmpty) return 'Please enter age';
        final age = int.tryParse(v);
        if (age == null || age < 0 || age > 120) return 'Age must be 0-120';
        return null;
      },
    );
  }
}