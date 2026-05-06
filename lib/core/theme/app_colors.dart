import 'package:flutter/material.dart';

abstract final class OjasColors {
  // Primary — Royal Blue
  static const saffron = Color(0xFF1565C0);
  static const saffronLight = Color(0xFF5E92F3);
  static const saffronDark = Color(0xFF003C8F);

  // Accent — Sky Blue
  static const gold = Color(0xFF29B6F6);
  static const goldLight = Color(0xFF81D4FA);

  // Backgrounds — Deep Navy
  static const deepPurple = Color(0xFF050E1F);
  static const surfacePurple = Color(0xFF0D2137);
  static const cardPurple = Color(0xFF132C4A);

  // Secondary — Cyan
  static const lotus = Color(0xFF00BCD4);
  static const lotusLight = Color(0xFF4DD0E1);

  // Neutral
  static const cream = Color(0xFFE8F4FD);
  static const creamDark = Color(0xFFCFE2F5);
  static const textPrimary = Color(0xFFE8F4FD);
  static const textSecondary = Color(0xFF90CAF9);
  static const textMuted = Color(0xFF5C8AC8);

  // Semantic
  static const success = Color(0xFF4CAF50);
  static const error = Color(0xFFE53935);
  static const warning = Color(0xFFFFA726);

  // Gradients
  static const saffronGradient = LinearGradient(
    colors: [saffron, saffronLight],
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

  // Blue hero gradient (navy → royal blue → sky blue)
  static const blueGradient = LinearGradient(
    colors: [saffronDark, saffron, gold],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
