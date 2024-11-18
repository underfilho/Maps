import 'package:flutter/material.dart';
import 'package:maps_app/app/ui/theme/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;

  const LoadingWidget({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? AppColors.of(context)?.primaryColor,
      ),
    );
  }
}
