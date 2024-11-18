import 'package:equatable/equatable.dart';
import 'package:maps_app/app/data/models/failure.dart';

enum SaveAddressStatus { initial, saving, error, saved }

class SaveAddressState extends Equatable {
  final SaveAddressStatus status;
  final Failure? failure;

  const SaveAddressState._({
    required this.status,
    this.failure,
  });

  const SaveAddressState.initial() : this._(status: SaveAddressStatus.initial);

  const SaveAddressState.saving() : this._(status: SaveAddressStatus.saving);

  const SaveAddressState.saved() : this._(status: SaveAddressStatus.saved);

  const SaveAddressState.error(Failure failure)
      : this._(status: SaveAddressStatus.initial, failure: failure);

  @override
  List<Object?> get props => [status, failure];
}
