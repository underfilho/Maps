import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color fieldsColor;
  final Color onBackgroundTextColor;
  final Color onBackgroundTextColorSecondary;
  final Color errorColor;

  AppColors({
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.fieldsColor,
    required this.onBackgroundTextColor,
    required this.onBackgroundTextColorSecondary,
    required this.errorColor,
  });

  AppColors.standard()
      : primaryColor = const Color(0xFF2E8896),
        secondaryColor = const Color(0xFFE8E8E8),
        backgroundColor = const Color(0xFFF6F6F6),
        fieldsColor = const Color(0xFF7C7C7C),
        onBackgroundTextColor = const Color(0xFF1C1B1F),
        onBackgroundTextColorSecondary = const Color(0xFF49454F),
        errorColor = Colors.red;

  @override
  AppColors copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? backgroundColor,
    Color? fieldsColor,
    Color? onBackgroundTextColor,
    Color? onBackgroundTextColorSecondary,
    Color? errorColor,
  }) {
    return AppColors(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fieldsColor: fieldsColor ?? this.fieldsColor,
      onBackgroundTextColor:
          onBackgroundTextColor ?? this.onBackgroundTextColor,
      onBackgroundTextColorSecondary:
          onBackgroundTextColorSecondary ?? this.onBackgroundTextColorSecondary,
      errorColor: errorColor ?? this.errorColor,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      fieldsColor: Color.lerp(fieldsColor, other.fieldsColor, t)!,
      onBackgroundTextColor:
          Color.lerp(onBackgroundTextColor, other.onBackgroundTextColor, t)!,
      onBackgroundTextColorSecondary: Color.lerp(onBackgroundTextColorSecondary,
          other.onBackgroundTextColorSecondary, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
    );
  }

  static AppColors? of(context) => Theme.of(context).extension<AppColors>();
}
