import 'package:flutter/material.dart';
import 'package:maps_app/app/ui/theme/app_colors.dart';
import 'package:maps_app/app/ui/theme/app_fonts.dart';

class InputText extends StatelessWidget {
  final String? hint;
  final TextEditingController? textController;
  final TextInputType? inputType;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool enabled;

  const InputText({
    super.key,
    this.hint,
    this.textController,
    this.inputType,
    this.focusNode,
    this.nextFocus,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      controller: textController,
      keyboardType: inputType,
      textInputAction: getTextInputAction(),
      onSubmitted: (_) => fieldFocusChange(context),
      focusNode: focusNode,
      decoration: InputDecoration(
        isDense: true,
        labelText: hint,
        labelStyle: AppFonts.of(context)?.caption.copyWith(fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: AppColors.of(context)!.primaryColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: AppColors.of(context)!.fieldsColor,
            width: 1,
          ),
        ),
      ),
    );
  }

  void fieldFocusChange(BuildContext context) {
    focusNode?.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  TextInputAction? getTextInputAction() {
    if (focusNode != null && nextFocus != null) return TextInputAction.next;
    if (focusNode != null) return TextInputAction.done;
    return null;
  }
}
