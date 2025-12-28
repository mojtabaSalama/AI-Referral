import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ComplaintSection extends StatelessWidget {
  final TextEditingController controller;
  const ComplaintSection({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              FaIcon(FontAwesomeIcons.notesMedical, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text('Chief Complaint', style: _titleStyle(context)),
            ]),
            const SizedBox(height: 16),
            TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Main Complaint *',
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 3,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Please describe the main complaint' : null,
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _titleStyle(BuildContext c) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(c).primaryColor,
      );
}