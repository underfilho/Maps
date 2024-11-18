import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/app/data/models/address.dart';
import 'package:maps_app/app/dependencies.dart';
import 'package:maps_app/app/ui/routes/myrouter_helper.dart';
import 'package:maps_app/app/ui/screens/save_adress/cubits/save_address_cubit.dart';
import 'package:maps_app/app/ui/screens/save_adress/cubits/save_address_state.dart';
import 'package:maps_app/app/ui/theme/app_fonts.dart';
import 'package:maps_app/app/ui/widgets/primary_button.dart';

import 'widgets/form_input_text.dart';

class SaveAddressScreen extends StatelessWidget {
  final Address address;
  final bool isNewAddress;

  const SaveAddressScreen(
      {super.key, required this.address, required this.isNewAddress});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SaveAddressCubit>(
      create: (_) => di.get(),
      child: _SaveAddressPage(address: address, isNewAddress: isNewAddress),
    );
  }
}

class _SaveAddressPage extends StatefulWidget {
  final Address address;
  final bool isNewAddress;

  const _SaveAddressPage({required this.address, required this.isNewAddress});

  @override
  State<_SaveAddressPage> createState() => _SaveAddressPageState();
}

class _SaveAddressPageState extends State<_SaveAddressPage> {
  final numberNode = FocusNode();
  final additionalInfoNode = FocusNode();

  final cepTextController = TextEditingController();
  final addressLineTextController = TextEditingController();
  final numberTextController = TextEditingController();
  final additionalInfoTextController = TextEditingController();

  SaveAddressCubit get cubit => context.read<SaveAddressCubit>();
  bool get isNewAddress => widget.isNewAddress;

  @override
  void initState() {
    super.initState();
    cepTextController.text = widget.address.CEP;
    addressLineTextController.text = widget.address.addressLine;
    if (widget.address.number != null)
      numberTextController.text = widget.address.number.toString();
    if (widget.address.additionalInfo != null)
      additionalInfoTextController.text = widget.address.additionalInfo!;
  }

  @override
  Widget build(BuildContext context) {
    numberNode.requestFocus();

    return Scaffold(
      appBar: AppBar(
        title: Text(isNewAddress ? 'Revisão' : 'Edição',
            style: AppFonts.of(context)?.title),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, bottom: 30, top: 5),
                child: Column(
                  children: [
                    InputText(
                      hint: 'CEP',
                      enabled: false,
                      textController: cepTextController,
                    ),
                    const SizedBox(height: 20),
                    InputText(
                      hint: 'Endereço',
                      enabled: false,
                      textController: addressLineTextController,
                    ),
                    const SizedBox(height: 20),
                    InputText(
                      hint: 'Número',
                      focusNode: numberNode,
                      nextFocus: additionalInfoNode,
                      textController: numberTextController,
                      inputType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    InputText(
                      hint: 'Complemento',
                      focusNode: additionalInfoNode,
                      textController: additionalInfoTextController,
                    ),
                    const SizedBox(height: 30),
                    const Spacer(),
                    BlocConsumer<SaveAddressCubit, SaveAddressState>(
                      listener: (context, state) {
                        if (state.status == SaveAddressStatus.saved)
                          context.pop();
                      },
                      builder: (_, state) {
                        final isLoading =
                            state.status == SaveAddressStatus.saving;

                        return PrimaryButton(
                          label: 'Confirmar',
                          isLoading: isLoading,
                          onTap: () {
                            final number = numberTextController.text.isNotEmpty
                                ? numberTextController.text
                                : null;
                            final additionalInfo =
                                additionalInfoTextController.text.isNotEmpty
                                    ? additionalInfoTextController.text
                                    : null;

                            final address = widget.address
                                .withAdditionalInfo(additionalInfo)
                                .withNumber(int.tryParse(number ?? ''));

                            isNewAddress
                                ? cubit.saveAddress(address)
                                : cubit.updateAddress(address);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
