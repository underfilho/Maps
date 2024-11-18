import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

mixin FloatingInfo {
  void showSnackbar(String message, BuildContext context,
      {Duration? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 2),
      ),
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }
}
