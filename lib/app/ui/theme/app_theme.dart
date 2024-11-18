import 'app_colors.dart';
import 'app_fonts.dart';

class AppTheme {
  final AppColors _appColors;
  late final AppFonts _appFonts;

  AppTheme() : _appColors = AppColors.standard() {
    _appFonts = AppFonts.fromAppColors(_appColors);
  }

  AppColors get appColors => _appColors;
  AppFonts get appFonts => _appFonts;
}
