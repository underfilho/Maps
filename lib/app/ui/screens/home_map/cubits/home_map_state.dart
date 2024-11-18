import 'package:equatable/equatable.dart';
import 'package:maps_app/app/data/models/address.dart';
import 'package:maps_app/app/data/models/failure.dart';

enum HomeMapStatus { initial, searching, error, found, selected }

class HomeMapState extends Equatable {
  final Address? address;
  final HomeMapStatus status;
  final Failure? failure;

  const HomeMapState._({
    required this.status,
    this.address,
    this.failure,
  });

  bool get hasAddress =>
      (status == HomeMapStatus.found || status == HomeMapStatus.selected) &&
      address != null;

  bool get hasCoordinates => address?.coordinates != null;

  bool get hasFailed => status == HomeMapStatus.error;

  bool get isNewAddress => status == HomeMapStatus.found;

  const HomeMapState.initial() : this._(status: HomeMapStatus.initial);

  const HomeMapState.searching() : this._(status: HomeMapStatus.searching);

  const HomeMapState.found(Address address)
      : this._(status: HomeMapStatus.found, address: address);

  const HomeMapState.selected(Address address)
      : this._(status: HomeMapStatus.selected, address: address);

  const HomeMapState.failed(Failure failure)
      : this._(status: HomeMapStatus.error, failure: failure);

  @override
  List<Object?> get props => [address, status, failure];
}
