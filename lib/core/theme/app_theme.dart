import 'package:flutter/material.dart';

abstract class AppTheme {
  static const _seedColor = Color(0xFF6C63FF);

  static final light = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: _seedColor,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: _seedColor,
    brightness: Brightness.dark,
  );
}