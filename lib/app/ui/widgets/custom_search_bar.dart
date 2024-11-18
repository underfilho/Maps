import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maps_app/app/ui/theme/app_colors.dart';
import 'package:maps_app/app/ui/theme/app_fonts.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? inputType;
  final void Function(String)? onDelayedChange;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.inputType,
    this.onDelayedChange,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.of(context)?.secondaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0.5, 1.0),
            blurRadius: 7,
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Icon(
              Icons.search,
              color: AppColors.of(context)?.fieldsColor,
            ),
          ),
          Flexible(
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: "Buscar",
                border: InputBorder.none,
                hintStyle: AppFonts.of(context)?.input,
              ),
              keyboardType: widget.inputType,
              style: AppFonts.of(context)?.input,
              cursorColor: AppColors.of(context)?.primaryColor,
              controller: widget.controller,
              onChanged: widget.onDelayedChange != null ? delayedSearch : null,
            ),
          ),
        ],
      ),
    );
  }

  Timer? _timer;

  void delayedSearch(String text) {
    if (_timer != null) _timer!.cancel();

    _timer = Timer(
      const Duration(milliseconds: 500),
      () => widget.onDelayedChange!(text),
    );
  }
}
