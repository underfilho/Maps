import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';
import 'package:maps_app/app/core/utils/extensions.dart';
import 'package:maps_app/app/ui/screens/home/widgets/bottom_bar_controller.dart';
import 'package:maps_app/app/ui/theme/app_colors.dart';
import 'package:maps_app/app/ui/theme/app_fonts.dart';

class BottomBarItem {
  final SvgIconData icon;
  final String label;

  BottomBarItem({required this.icon, required this.label});
}

class CustomBottomBar extends StatefulWidget {
  final List<Widget> pages;
  final List<BottomBarItem> items;
  final BottomBarController controller;

  const CustomBottomBar({
    super.key,
    required this.pages,
    required this.items,
    required this.controller,
  });

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  Widget get actualPage => widget.pages[selectedIndex];

  @override
  void initState() {
    super.initState();

    widget.controller.setPage = (index) {
      setState(() => selectedIndex = index);
    };
  }

  @override
  Widget build(BuildContext context) {
    double? height;

    return LayoutBuilder(builder: (context, constraints) {
      height ??= constraints.maxHeight;

      return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: height! - 75,
              child: actualPage,
            ),
            SizedBox(
              height: 75,
              child: _BottomBarWidget(
                items: widget.items,
                selectedIndex: selectedIndex,
                onSelected: (index) {
                  setState(() => selectedIndex = index);
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _BottomBarWidget extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onSelected;
  final List<BottomBarItem> items;

  const _BottomBarWidget({
    required this.items,
    required this.onSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.of(context)?.backgroundColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0.5, -2.0),
            blurRadius: 7,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.mapIndexed((i, item) {
          final focused = i == selectedIndex;

          return GestureDetector(
            onTap: () => onSelected(i),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _FocusableIcon(focused: focused, icon: item.icon),
                Text(
                  item.label,
                  style: AppFonts.of(context)?.caption.copyWith(
                        color: focused
                            ? AppColors.of(context)?.primaryColor
                            : AppColors.of(context)?.fieldsColor,
                        fontWeight:
                            focused ? FontWeight.bold : FontWeight.normal,
                      ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _FocusableIcon extends StatelessWidget {
  final bool focused;
  final SvgIconData icon;

  const _FocusableIcon({required this.focused, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color:
            AppColors.of(context)?.primaryColor.withOpacity(focused ? 0.15 : 0),
      ),
      child: SvgIcon(
        icon: icon,
        size: 28,
        color: focused
            ? AppColors.of(context)?.primaryColor
            : AppColors.of(context)?.fieldsColor,
      ),
    );
  }
}
