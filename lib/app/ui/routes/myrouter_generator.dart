import 'package:flutter/material.dart';
import 'package:maps_app/app/data/models/address.dart';
import 'package:maps_app/app/ui/screens/home/home_screen.dart';
import 'package:maps_app/app/ui/screens/save_adress/save_address_screen.dart';

class MyRouterGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/save_address':
        final data = args as (Address, bool);
        return MaterialPageRoute(
            builder: (_) =>
                SaveAddressScreen(address: data.$1, isNewAddress: data.$2));
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
