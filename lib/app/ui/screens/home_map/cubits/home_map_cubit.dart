import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/app/data/models/address.dart';
import 'package:maps_app/app/data/repositories/address_repository.dart';
import 'home_map_state.dart';

class HomeMapCubit extends Cubit<HomeMapState> {
  final AddressRepository _repository;

  HomeMapCubit(this._repository) : super(const HomeMapState.initial());

  void searchPostalCode(String postalCode) async {
    emit(const HomeMapState.searching());

    final response = await _repository.getAddressByPostalCode(postalCode);

    response.fold(
      (failure) => emit(HomeMapState.failed(failure)),
      (address) => emit(HomeMapState.found(address)),
    );
  }

  void setAddress(Address address, bool isExisting) {
    emit(isExisting
        ? HomeMapState.selected(address)
        : HomeMapState.found(address));
  }

  void closeAddress() => emit(const HomeMapState.initial());
}
