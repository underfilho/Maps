import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/app/data/repositories/address_repository.dart';
import 'package:maps_app/app/ui/screens/addresses/cubits/addresses_state.dart';

class AddressesCubit extends Cubit<AddressesState> {
  final AddressRepository _repository;

  AddressesCubit(this._repository) : super(const AddressesState.initial());

  void init() async {
    emit(const AddressesState.loading());

    final response = await _repository.getSavedAddresses();

    response.fold(
      (failure) => emit(AddressesState.error(failure)),
      (addresses) {
        final items =
            addresses.map((e) => AddressItem(address: e, save: true)).toList();
        emit(AddressesState.done(items));
      },
    );
  }

  void unsaveAddress(AddressItem item) {
    final addressId = item.address.id;

    final addresses = state.items!.map((e) {
      if (e.address.id == addressId) return e.withSave(false);
      return e;
    }).toList();

    emit(AddressesState.done(addresses));
  }

  void saveAddress(AddressItem item) {
    final addressId = item.address.id;

    final addresses = state.items!.map((e) {
      if (e.address.id == addressId) return e.withSave(true);
      return e;
    }).toList();

    emit(AddressesState.done(addresses));
  }

  @override
  Future<void> close() {
    final itemsToRemove = state.items?.where((e) => !e.save) ?? [];
    itemsToRemove.forEach((e) => _repository.removeAddress(e.address));

    return super.close();
  }
}
