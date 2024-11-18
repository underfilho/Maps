import 'package:flutter/material.dart';
import 'package:maps_app/app/ui/theme/app_colors.dart';
import 'package:maps_app/app/ui/theme/app_fonts.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.close,
          size: 28,
          color: AppColors.of(context)?.fieldsColor,
        ),
        const SizedBox(height: 10),
        Text(
          'Nehum endereço salvo',
          style: AppFonts.of(context)
              ?.bodyTextTitle
              .copyWith(color: AppColors.of(context)?.fieldsColor),
        )
      ],
    );
  }
}
