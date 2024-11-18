import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/app/data/models/address.dart';
import 'package:maps_app/app/data/repositories/address_repository.dart';
import 'package:maps_app/app/ui/screens/save_adress/cubits/save_address_state.dart';

class SaveAddressCubit extends Cubit<SaveAddressState> {
  final AddressRepository _repository;

  SaveAddressCubit(this._repository) : super(const SaveAddressState.initial());

  void saveAddress(Address address) async {
    emit(const SaveAddressState.saving());
    final response = await _repository.addAddress(address);

    response.fold(
      () => emit(const SaveAddressState.saved()),
      (a) {},
    );
  }

  void updateAddress(Address address) async {
    emit(const SaveAddressState.saving());
    final response = await _repository.updateAddress(address);

    response.fold(
      () => emit(const SaveAddressState.saved()),
      (a) {},
    );
  }
}
