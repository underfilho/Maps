import 'package:flutter/material.dart';
import 'package:maps_app/app/ui/screens/addresses/cubits/addresses_state.dart';
import 'package:maps_app/app/ui/theme/app_colors.dart';
import 'package:maps_app/app/ui/theme/app_fonts.dart';

class AddressItemWidget extends StatefulWidget {
  final AddressItem item;
  final VoidCallback onTap;
  final void Function(bool) onBookmark;

  const AddressItemWidget({
    super.key,
    required this.item,
    required this.onTap,
    required this.onBookmark,
  });

  @override
  State<AddressItemWidget> createState() => _AddressItemWidgetState();
}

class _AddressItemWidgetState extends State<AddressItemWidget> {
  late bool saved = widget.item.save;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.item.address.formattedCEP,
                    style: AppFonts.of(context)?.bodyTextTitle),
                const SizedBox(height: 2),
                Text(
                  widget.item.address.addressLine,
                  style: AppFonts.of(context)?.bodyText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() => saved = !saved);
              widget.onBookmark(saved);
            },
            icon: Icon(
              Icons.bookmark,
              color: saved
                  ? AppColors.of(context)?.primaryColor
                  : AppColors.of(context)?.fieldsColor,
            ),
          ),
        ],
      ),
    );
  }
}
