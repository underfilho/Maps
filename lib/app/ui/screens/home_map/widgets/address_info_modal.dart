import 'package:flutter/material.dart';
import 'package:maps_app/app/data/models/address.dart';
import 'package:maps_app/app/ui/theme/app_colors.dart';
import 'package:maps_app/app/ui/theme/app_fonts.dart';
import 'package:maps_app/app/ui/widgets/primary_button.dart';

class AddressInfoModal extends StatelessWidget {
  final Address address;
  final bool isNewAddress;
  final VoidCallback onTap;

  const AddressInfoModal({
    super.key,
    required this.address,
    required this.isNewAddress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.of(context)?.backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      width: double.infinity,
      padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(address.formattedCEP, style: AppFonts.of(context)?.title),
          const SizedBox(height: 5),
          Text(address.addressLine, style: AppFonts.of(context)?.bodyText),
          const SizedBox(height: 20),
          PrimaryButton(
            onTap: onTap,
            label: isNewAddress ? 'Salvar endereço' : 'Editar endereço',
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
