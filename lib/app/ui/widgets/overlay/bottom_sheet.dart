import 'package:flutter/material.dart';

mixin BottomSheets {
  Future<void> showInfoBottomSheet({
    required BuildContext context,
    required Widget child,
  }) async {
    return showModalBottomSheet(
      context: context,
      elevation: 3,
      barrierColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => child,
    );
  }
}
