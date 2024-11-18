import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/app/data/models/address.dart';
import 'package:maps_app/app/data/models/failure.dart';
import 'package:maps_app/app/ui/routes/myrouter_helper.dart';
import 'package:maps_app/app/ui/screens/home_map/cubits/home_map_cubit.dart';
import 'package:maps_app/app/ui/screens/home_map/cubits/home_map_state.dart';
import 'package:maps_app/app/ui/screens/home_map/widgets/address_info_modal.dart';
import 'package:maps_app/app/ui/theme/app_colors.dart';
import 'package:maps_app/app/ui/widgets/custom_search_bar.dart';
import 'package:maps_app/app/ui/widgets/loading_widget.dart';
import 'package:maps_app/app/ui/widgets/overlay/bottom_sheet.dart';
import 'package:maps_app/app/ui/widgets/overlay/floating_info.dart';

class HomeMapPage extends StatefulWidget {
  const HomeMapPage({super.key});

  @override
  State<HomeMapPage> createState() => _HomeMapPageState();
}

class _HomeMapPageState extends State<HomeMapPage>
    with FloatingInfo, BottomSheets {
  final TextEditingController cepTextField = TextEditingController();
  GoogleMapController? _controller;

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(-13.0031, -38.5102),
    zoom: 16,
  );

  HomeMapCubit get cubit => context.read<HomeMapCubit>();

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).viewPadding.top;

    return Stack(
      children: [
        BlocConsumer<HomeMapCubit, HomeMapState>(
          listenWhen: (previous, current) => current != previous,
          listener: onNewState,
          builder: (_, state) {
            final markers = <Marker>{};
            if (state.hasCoordinates) {
              markers.add(getMarker(state.address!));
              animateCamera(markers.first);
            }

            return GoogleMap(
              zoomControlsEnabled: false,
              onMapCreated: (controller) {
                _controller = controller;
                if (markers.isNotEmpty) animateCamera(markers.first);
              },
              initialCameraPosition: _initialPosition,
              markers: markers,
            );
          },
        ),
        Container(
          margin: EdgeInsets.only(right: 10, left: 10, top: topPadding + 10),
          width: double.infinity,
          height: 50,
          child: CustomSearchBar(
            controller: cepTextField,
            inputType: TextInputType.number,
          ),
        ),
        Positioned(
          bottom: 20,
          right: 15,
          child: BlocBuilder<HomeMapCubit, HomeMapState>(
            builder: (context, state) => _SearchFloatingButton(
              isLoading: state.status == HomeMapStatus.searching,
              onTap: () async {
                final cep = cepTextField.text;
                if (cep.isEmpty) return;

                cubit.searchPostalCode(cep);
              },
            ),
          ),
        ),
      ],
    );
  }

  void showAddressInfo(
      BuildContext context, Address address, bool isNewAddress) {
    showInfoBottomSheet(
      context: context,
      child: AddressInfoModal(
        address: address,
        isNewAddress: isNewAddress,
        onTap: () {
          context.pop();
          context.push('/save_address', args: (address, isNewAddress));
        },
      ),
    ).then((_) {
      cubit.closeAddress();
    });
  }

  Marker getMarker(Address address) {
    final latlng = LatLng(address.coordinates!.$1, address.coordinates!.$2);
    return Marker(markerId: MarkerId(address.CEP), position: latlng);
  }

  void animateCamera(Marker marker) {
    _controller?.animateCamera(CameraUpdate.newLatLngZoom(marker.position, 16));
  }

  void onNewState(BuildContext context, HomeMapState state) {
    if (state.hasFailed) showError(context, state.failure!);

    if (state.hasAddress) {
      if (!state.hasCoordinates) showToast('Localização exata não encontrada.');

      showAddressInfo(
        context,
        state.address!,
        state.isNewAddress,
      );
    }
  }

  void showError(BuildContext context, Failure failure) {
    if (failure is HttpFailure) {
      if (failure.code == 400 || failure.code == 400)
        return showSnackbar('CEP não encontrado.', context);
      return showSnackbar('Erro na requisição.', context);
    }

    if (failure is TimeoutFailure)
      return showSnackbar('Tempo excedido, verifique sua conexão.', context);

    if (failure is NoConnectionFailure)
      return showSnackbar('Erro de conexão.', context);

    return showSnackbar('Erro desconhecido.', context);
  }
}

class _SearchFloatingButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLoading;

  const _SearchFloatingButton({required this.onTap, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: AppColors.of(context)?.primaryColor,
      onPressed: onTap,
      child: !isLoading
          ? Icon(
              Icons.search,
              color: AppColors.of(context)?.backgroundColor,
            )
          : Transform.scale(
              scale: .5,
              child:
                  LoadingWidget(color: AppColors.of(context)?.backgroundColor),
            ),
    );
  }
}
