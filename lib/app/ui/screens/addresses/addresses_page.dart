import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/app/dependencies.dart';
import 'package:maps_app/app/ui/screens/addresses/cubits/addresses_cubit.dart';
import 'package:maps_app/app/ui/screens/addresses/cubits/addresses_state.dart';
import 'package:maps_app/app/ui/screens/addresses/cubits/search_address_cubit.dart';
import 'package:maps_app/app/ui/screens/addresses/widgets/address_item_widget.dart';
import 'package:maps_app/app/ui/screens/addresses/widgets/empty_screen.dart';
import 'package:maps_app/app/ui/screens/home/widgets/bottom_bar_controller.dart';
import 'package:maps_app/app/ui/screens/home_map/cubits/home_map_cubit.dart';
import 'package:maps_app/app/ui/theme/app_colors.dart';
import 'package:maps_app/app/ui/widgets/custom_search_bar.dart';
import 'package:maps_app/app/ui/widgets/loading_widget.dart';
import 'package:maps_app/app/ui/widgets/overlay/floating_info.dart';

class AddressesPage extends StatelessWidget {
  final BottomBarController controller;

  const AddressesPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddressesCubit>(create: (_) => di.get()),
        BlocProvider<SearchAddressCubit>(create: (_) => di.get()),
      ],
      child: _AddressesPage(controller: controller),
    );
  }
}

class _AddressesPage extends StatefulWidget {
  final BottomBarController controller;

  const _AddressesPage({required this.controller});

  @override
  State<_AddressesPage> createState() => _AddressesPageState();
}

class _AddressesPageState extends State<_AddressesPage> with FloatingInfo {
  final searchTextField = TextEditingController();

  @override
  void initState() {
    super.initState();
    addressesCubit.init();
  }

  AddressesCubit get addressesCubit => context.read<AddressesCubit>();
  SearchAddressCubit get searchAddressCubit =>
      context.read<SearchAddressCubit>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.of(context)?.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: double.infinity,
              height: 50,
              child: CustomSearchBar(
                controller: searchTextField,
                inputType: TextInputType.number,
                onDelayedChange: (text) => searchAddressCubit.search(text),
              ),
            ),
            BlocBuilder<AddressesCubit, AddressesState>(
              builder: (context, state) =>
                  BlocBuilder<SearchAddressCubit, String>(
                builder: (context, searchText) {
                  final height = MediaQuery.of(context).size.height;

                  if (state.status == AddressesStatus.loading) {
                    return Container(
                      margin: EdgeInsets.only(top: height / 3),
                      child: const LoadingWidget(),
                    );
                  }

                  final items = state.items ?? [];
                  final filteredItems = items
                      .where((e) => e.address.CEP.contains(searchText))
                      .toList();

                  if (filteredItems.isEmpty) {
                    return Container(
                      margin: EdgeInsets.only(top: height / 3),
                      child: const EmptyScreen(),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredItems.length,
                    separatorBuilder: (_, id) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: .5,
                      color: AppColors.of(context)?.fieldsColor,
                    ),
                    itemBuilder: (_, id) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: AddressItemWidget(
                        item: filteredItems[id],
                        onTap: () => onSelectAddress(filteredItems[id]),
                        onBookmark: (saved) {
                          if (saved) {
                            showSnackbar('Endereço salvo.', context);
                            addressesCubit.saveAddress(filteredItems[id]);
                          } else {
                            showSnackbar(
                              'Endereço será removido ao sair da página.',
                              context,
                            );
                            addressesCubit.unsaveAddress(filteredItems[id]);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSelectAddress(AddressItem address) async {
    widget.controller.setPage!(0);
    final homeCubit = context.read<HomeMapCubit>();

    await Future.delayed(const Duration(milliseconds: 100));
    homeCubit.setAddress(address.address, address.save);
  }
}
