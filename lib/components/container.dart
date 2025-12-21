import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
   final String label;
final String value;
   final IconData icon;
   final Color backgroundcolor;
   final Color iconcolor;
   

  const MyContainer({super.key ,required this.label,required this.value , required this.backgroundcolor,required this.icon,required this.iconcolor});

  @override
  Widget build(BuildContext context) {
           return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundcolor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:  Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 12,
            right: 12,
            child: Icon(icon, size: 32, color: iconcolor),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B7280),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                 
                ],
              ),
            ],
          ),
        ],
      ),
    ); }
}