import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final Color color;

  const SplashScreen({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: color,
      child: SafeArea(
        child: Center(
          child: SizedBox(
            height: 120,
            width: 120,
            child: Image.asset('assets/intro.gif'),
          ),
        ),
      ),
    );
  }
}
