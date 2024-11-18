import 'package:flutter_bloc/flutter_bloc.dart';

class SearchAddressCubit extends Cubit<String> {
  SearchAddressCubit() : super('');

  void search(String text) => emit(text);
}
