import 'package:flutter/material.dart';

/// Centralized color palette for the portfolio dark theme.
/// Purple + Blue gradient identity with glassmorphism accents.
abstract final class AppColors {
  static const Color primaryPurple = Color(0xFF7C3AED);
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color accentCyan = Color(0xFF06B6D4);
  static const Color accentPink = Color(0xFFEC4899);

  static const Color backgroundDark = Color(0xFF0A0A0F);
  static const Color surfaceDark = Color(0xFF12121A);
  static const Color cardDark = Color(0xFF1A1A2E);
  static const Color glassWhite = Color(0x1AFFFFFF);
  static const Color glassBorder = Color(0x33FFFFFF);

  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  /// Primary brand gradient used across hero, buttons, and accents.
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryPurple, primaryBlue],
  );

  /// Subtle background gradient for section overlays.
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0A0A0F), Color(0xFF0F0F1A), Color(0xFF0A0A0F)],
  );

  /// Radial glow for hero and decorative elements.
  static const RadialGradient glowGradient = RadialGradient(
    colors: [Color(0x337C3AED), Color(0x002563EB)],
    radius: 0.8,
  );
}
