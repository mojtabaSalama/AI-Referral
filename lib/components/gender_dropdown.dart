import 'package:flutter/material.dart';

class GenderDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  const GenderDropdown({required this.value, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value.isEmpty ? null : value,
      decoration: const InputDecoration(hintText: 'Gender *', prefixIcon: Icon(Icons.people)),
      items: ['Male', 'Female'].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
      onChanged: (v) => onChanged(v!),
      validator: (v) => (v == null || v.isEmpty) ? 'Please select gender' : null,
    );
  }
}