import 'package:flutter/material.dart';
import 'package:maps_app/app/ui/theme/app_colors.dart';
import 'package:maps_app/app/ui/theme/app_fonts.dart';
import 'package:maps_app/app/ui/widgets/loading_widget.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.label,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.of(context)?.primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: !isLoading
              ? Text(label, style: AppFonts.of(context)?.button)
              : const LoadingWidget(),
        ),
      ),
    );
  }
}
