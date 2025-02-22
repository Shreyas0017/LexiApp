import 'package:flutter/material.dart';
import '../utils/constants/colors.dart';

class AppTheme {
  static ThemeData getTheme(bool useOpenDyslexicFont) {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.text),
        bodyMedium: TextStyle(color: AppColors.text),
      ),
      fontFamily: useOpenDyslexicFont ? 'OpenDyslexic' : 'Roboto',
    );
  }
}