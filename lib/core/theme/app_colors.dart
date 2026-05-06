import 'package:flutter/material.dart';

abstract final class OjasColors {
  // Primary — Saffron/Orange
  static const saffron = Color(0xFFFF6B00);
  static const saffronLight = Color(0xFFFF8C42);
  static const saffronDark = Color(0xFFCC5500);

  // Accent — Gold
  static const gold = Color(0xFFFFD700);
  static const goldLight = Color(0xFFFFE566);

  // Backgrounds
  static const deepPurple = Color(0xFF1A0A2E);
  static const surfacePurple = Color(0xFF2D1B4E);
  static const cardPurple = Color(0xFF3D2266);

  // Secondary — Lotus Pink
  static const lotus = Color(0xFFE91E8C);
  static const lotusLight = Color(0xFFF06BAF);

  // Neutral
  static const cream = Color(0xFFFFF8E7);
  static const creamDark = Color(0xFFF5EDD6);
  static const textPrimary = Color(0xFFF5EDD6);
  static const textSecondary = Color(0xFFB89FCC);
  static const textMuted = Color(0xFF7A6B8A);

  // Semantic
  static const success = Color(0xFF4CAF50);
  static const error = Color(0xFFE53935);
  static const warning = Color(0xFFFFA726);

  // Gradients
  static const saffronGradient = LinearGradient(
    colors: [saffron, Color(0xFFFF9500)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const deepGradient = LinearGradient(
    colors: [deepPurple, surfacePurple],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const goldGradient = LinearGradient(
    colors: [gold, saffron],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
