import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onSubmit;
  const ActionButtons({required this.onSubmit, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onSubmit,
          iconAlignment: IconAlignment.end,
          label: const Text('Submit for Prediction', style: TextStyle(color: Colors.white, fontSize: 18)),
          icon: const Icon(Icons.medical_services, color: Colors.white),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}