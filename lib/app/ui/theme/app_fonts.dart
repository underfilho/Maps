import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppFonts extends ThemeExtension<AppFonts> {
  final TextStyle title;
  final TextStyle input;
  final TextStyle bodyTextTitle;
  final TextStyle bodyText;
  final TextStyle caption;
  final TextStyle button;

  AppFonts._({
    required this.title,
    required this.input,
    required this.bodyTextTitle,
    required this.bodyText,
    required this.caption,
    required this.button,
  });

  AppFonts.fromAppColors(AppColors appColors)
      : this._(
          title: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: appColors.onBackgroundTextColor),
          input: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: appColors.fieldsColor),
          bodyTextTitle: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: appColors.onBackgroundTextColor),
          bodyText: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: appColors.onBackgroundTextColorSecondary),
          caption: GoogleFonts.roboto(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: appColors.fieldsColor),
          button: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: appColors.backgroundColor),
        );

  @override
  AppFonts copyWith({
    TextStyle? title,
    TextStyle? input,
    TextStyle? bodyTextTitle,
    TextStyle? bodyText,
    TextStyle? caption,
    TextStyle? button,
  }) {
    return AppFonts._(
      title: title ?? this.title,
      input: input ?? this.input,
      bodyTextTitle: bodyTextTitle ?? this.bodyTextTitle,
      bodyText: bodyText ?? this.bodyText,
      caption: caption ?? this.caption,
      button: button ?? this.button,
    );
  }

  @override
  AppFonts lerp(ThemeExtension<AppFonts>? other, double t) {
    if (other is! AppFonts) return this;

    return other;
  }

  static AppFonts? of(context) => Theme.of(context).extension<AppFonts>();
}
