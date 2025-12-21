import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final void Function()? function;
  final Color bgColor;
  final Color textColor;
  final String text;
  final IconData icon;
  const FloatingButton({super.key ,required this.bgColor,required this.function,required this.icon, required this.text, required this.textColor});

  @override
  Widget build(BuildContext context) {
   
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10 ,horizontal: 15),
    width: double.maxFinite,
    child: ElevatedButton(
      onPressed:function,
      style: ElevatedButton.styleFrom(
        
        backgroundColor:bgColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
      ),
      child:  Row(
        mainAxisSize: MainAxisSize.min,
        
        children: [
         
          
          Text(
            text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: textColor),
          ),
          SizedBox(width: 8),
           Icon(icon, size: 30),
        ],
      ),
    ),
  );

  }
}