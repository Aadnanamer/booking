import 'package:flutter/material.dart';

class BottomBarItem {
  final String key;
  final IconData icon;
  final VoidCallback onPressed;

  BottomBarItem({required this.onPressed,required this.icon,required this.key});
}
