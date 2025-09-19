import 'package:flutter/material.dart';

class FlexAudioPlayerCardDefaultValue {
  // Size
  final double iconSize = 28.0;

  // Color
  final Color white = Color(0xFFFFFFFF);
  final Color primary = Color(0xFF467AF9);

  // Text Style
  final TextStyle durationTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.grey.shade600,
  );

  // Padding
  final EdgeInsetsGeometry padding = EdgeInsets.symmetric(
    vertical: 12,
    horizontal: 12,
  );

  // Border Radius
  final BorderRadiusGeometry borderRadius = BorderRadius.all(
    Radius.circular(8),
  );
}
