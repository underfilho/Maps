import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:maps_app/app/core/utils/const.dart';
import 'package:maps_app/app/dependencies.dart';
import 'package:maps_app/app/ui/screens/addresses/addresses_page.dart';
import 'package:maps_app/app/ui/screens/home/widgets/bottom_bar_controller.dart';
import 'package:maps_app/app/ui/screens/home/widgets/custom_bottom_bar.dart';
import 'package:maps_app/app/ui/screens/home_map/cubits/home_map_cubit.dart';
import 'package:maps_app/app/ui/screens/home_map/home_map_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeMapCubit>(
      create: (_) => di.get(),
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  final controller = BottomBarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBottomBar(
        controller: controller,
        pages: [
          const HomeMapPage(),
          AddressesPage(controller: controller),
        ],
        items: [
          BottomBarItem(
            icon: const SvgIconData(mapsIconSvg),
            label: 'Mapa',
          ),
          BottomBarItem(
            icon: const SvgIconData(notebookIconSvg),
            label: 'Caderneta',
          )
        ],
      ),
    );
  }
}
