import 'package:get_it/get_it.dart';
import 'package:maps_app/app/data/datasources/local_address_db.dart';
import 'package:maps_app/app/data/datasources/rest_client.dart';
import 'package:maps_app/app/data/repositories/address_repository.dart';
import 'package:maps_app/app/ui/screens/addresses/cubits/addresses_cubit.dart';
import 'package:maps_app/app/ui/screens/addresses/cubits/search_address_cubit.dart';
import 'package:maps_app/app/ui/screens/home_map/cubits/home_map_cubit.dart';
import 'package:maps_app/app/ui/screens/save_adress/cubits/save_address_cubit.dart';

final di = GetIt.instance;

void initDependencies() {
  di.registerSingleton(RestClient());
  di.registerSingletonAsync(() => LocalAddressDB().initDB());
  di.registerSingletonWithDependencies(
      () => AddressRepository(di.get(), di.get()),
      dependsOn: [LocalAddressDB]);

  di.registerFactory(() => HomeMapCubit(di.get()));
  di.registerFactory(() => AddressesCubit(di.get()));
  di.registerFactory(() => SearchAddressCubit());
  di.registerFactory(() => SaveAddressCubit(di.get()));
}
