import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2D62ED);
  static const Color secondary = Color(0xFFE9F0FF);
  static const Color accent = Color(0xFF40C4FF);
  static const Color background = Color(0xFFF8F9FE);
  static const Color textDark = Color(0xFF1A1C1E);
  static const Color textGrey = Color(0xFF6C757D);
  static const Color white = Colors.white;
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
    letterSpacing: -0.5,
  );

  static const TextStyle subHeading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.textGrey,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
