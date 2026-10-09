import 'package:flutter/material.dart';
import 'package:webspark_task/shared/constants/constants.dart';
import 'package:webspark_task/shared/constants/theme/app_colors.dart';

abstract class AppTheme {
  static ThemeData get light {
    const colorScheme = ColorScheme.light(
      primary: AppColors.primaryColor,
      onPrimary: AppColors.buttonTextColor,
      surface: AppColors.emptyCell,
      onSurface: AppColors.lockedCell,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.emptyCell,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.buttonTextColor,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonBackgroundColor,
          foregroundColor: AppColors.buttonTextColor,
          disabledBackgroundColor: AppColors.disabledButtonBackgroundColor,
          disabledForegroundColor: AppColors.buttonTextColor,
          elevation: AppSizes.btnElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.btnBorderRadius),
          ),
        ),
      ),
    );
  }
}
