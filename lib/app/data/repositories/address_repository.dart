import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maps_app/app/data/datasources/local_address_db.dart';
import 'package:maps_app/app/data/datasources/rest_client.dart';
import 'package:maps_app/app/data/models/address.dart';
import 'package:maps_app/app/data/models/failure.dart';

class AddressRepository {
  final RestClient _restClient;
  final LocalAddressDB _db;

  AddressRepository(this._restClient, this._db);

  Future<Either<Failure, Address>> getAddressByPostalCode(
      String postalCode) async {
    final endpoint = 'api/cep/v2/$postalCode';

    try {
      final response = await _restClient.get(endpoint);

      if (response.statusCode == 200) {
        final address = Address.fromJson(response.data);
        return right(address);
      } else {
        return left(HttpFailure(code: response.statusCode));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout)
          return left(TimeoutFailure());
        if (e.type == DioExceptionType.connectionError)
          return left(NoConnectionFailure());
      }

      if (e is SocketException) return left(NoConnectionFailure());
      return left(UnknownFailure());
    }
  }

  Future<Either<Failure, List<Address>>> getSavedAddresses() async {
    final addresses = await _db.getAll();
    return right(addresses);
  }

  Future<Option<Failure>> addAddress(Address address) async {
    await _db.insert(address);
    return none();
  }

  Future<Option<Failure>> removeAddress(Address address) async {
    await _db.delete(address.id);
    return none();
  }

  Future<Option<Failure>> updateAddress(Address address) async {
    await _db.update(address.id, address);
    return none();
  }
}
