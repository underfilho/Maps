import 'package:equatable/equatable.dart';
import 'package:maps_app/app/data/models/address.dart';
import 'package:maps_app/app/data/models/failure.dart';

class AddressItem {
  final Address address;
  final bool save;

  AddressItem({required this.address, required this.save});

  AddressItem withSave(bool save) {
    return AddressItem(address: address, save: save);
  }
}

enum AddressesStatus { initial, loading, error, done }

class AddressesState extends Equatable {
  final List<AddressItem>? items;
  final AddressesStatus status;
  final Failure? failure;

  const AddressesState._({
    required this.status,
    this.items,
    this.failure,
  });

  const AddressesState.initial() : this._(status: AddressesStatus.initial);

  const AddressesState.loading() : this._(status: AddressesStatus.loading);

  const AddressesState.done(List<AddressItem> addresses)
      : this._(status: AddressesStatus.done, items: addresses);

  const AddressesState.error(Failure failure)
      : this._(status: AddressesStatus.error, failure: failure);

  @override
  List<Object?> get props => [items, status, failure];
}
