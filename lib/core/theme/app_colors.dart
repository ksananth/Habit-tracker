import 'package:flutter/material.dart';

abstract class AppColors {
  // ── Brand ──────────────────────────────────────────────────────────────────
  static const primary        = Color(0xFFFFD600);
  static const primaryLight   = Color(0xFFFFF9C4);

  static const dark           = Color(0xFF1A1A1A);
  static const muted          = Color(0xFF757575);
  static const white          = Color(0xFFFFFFFF);

  // ── Semantic ───────────────────────────────────────────────────────────────
  static const screenBg       = primary;
  static const cardLight      = primaryLight;
  static const appBarBg       = primary;

  // ── Buttons ────────────────────────────────────────────────────────────────
  static const buttonBg       = dark;
  static const buttonFg       = white;
  static const outlineBorder  = dark;
  static const outlineFg      = dark;

  // ── Legacy aliases (kept so nothing breaks) ────────────────────────────────
  static const lime           = primary;
  static const limeLight      = primaryLight;
  static const splash         = Color(0xFF121212);
  static const buttonPrimary  = buttonBg;
  static const buttonText     = buttonFg;
}
