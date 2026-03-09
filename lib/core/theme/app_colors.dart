import 'package:flutter/material.dart';

abstract class AppColors {
  // ── Brand ──────────────────────────────────────────────────────────────────
  static const primary        = Color(0xFFFFD600); // perfect yellow
  static const primaryLight   = Color(0xFFFFF9C4); // light yellow (cards / inputs)

  // ── Neutrals ───────────────────────────────────────────────────────────────
  static const dark           = Color(0xFF1A1A1A); // near-black text & icons
  static const muted          = Color(0xFF757575); // secondary text
  static const white          = Color(0xFFFFFFFF);

  // ── Semantic ───────────────────────────────────────────────────────────────
  static const screenBg       = primary;           // all scaffold backgrounds
  static const cardLight      = primaryLight;      // habit / attendance cards
  static const appBarBg       = primary;

  // ── Buttons ────────────────────────────────────────────────────────────────
  static const buttonBg       = dark;              // ElevatedButton fill
  static const buttonFg       = white;             // ElevatedButton label
  static const outlineBorder  = dark;              // OutlinedButton border
  static const outlineFg      = dark;              // OutlinedButton label

  // ── Legacy aliases (kept so nothing breaks) ────────────────────────────────
  static const lime           = primary;
  static const limeLight      = primaryLight;
  static const splash         = Color(0xFF121212);
  static const buttonPrimary  = buttonBg;
  static const buttonText     = buttonFg;
}
