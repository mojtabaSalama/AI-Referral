import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final BuildContext context;
  final String label;
   final String value; 
  final Color backgroundcolor;
  final IconData icon;
   final Color color;
  const StatCard({super.key,required this.context,required this.label, required this.backgroundcolor, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
     return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: backgroundcolor, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color:color.withValues(alpha: 0.12),
             shape: BoxShape.circle), child: Icon(icon, color: color, size: 20)),
            ]),
          const SizedBox(height: 20 ),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 4),
          Text(value, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          ],
      ),
    );
  }
}