import 'package:flutter/material.dart';
import 'package:maps_app/app/ui/routes/myrouter_generator.dart';
import 'package:maps_app/app/ui/theme/app_theme.dart';
import 'package:maps_app/app/ui/widgets/splash_screen.dart';
import 'app/dependencies.dart';

void main() {
  initDependencies();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme();

    return FutureBuilder(
      future: delayedStart(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: SplashScreen(color: appTheme.appColors.primaryColor),
          );
        }

        return MaterialApp(
          theme: ThemeData(
            primaryColor: appTheme.appColors.primaryColor,
            extensions: [appTheme.appColors, appTheme.appFonts],
          ),
          onGenerateRoute: MyRouterGenerator.onGenerateRoute,
        );
      },
    );
  }

  Future<void> delayedStart() {
    return Future.wait([
      di.allReady(),
      Future.delayed(const Duration(seconds: 2)),
    ]);
  }
}
