import 'package:flutter/material.dart';

Color painColorFor(double level) {
  if (level <= 2) return Colors.green;
  if (level <= 4) return Colors.orange;
  return Colors.red;
}