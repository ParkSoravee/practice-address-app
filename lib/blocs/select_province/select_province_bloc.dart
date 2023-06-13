import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practices/repositories/location_repository.dart';

import '../../models/province.dart';

part 'select_province_event.dart';
part 'select_province_state.dart';

class SelectProvinceBloc
    extends Bloc<SelectProvinceEvent, SelectProvinceState> {
  final LocationRepository locationRepository;
  SelectProvinceBloc(this.locationRepository) : super(SelectProvinceInitial()) {
    on<SelectProvinceSearch>((event, emit) async {
      final provinces = await locationRepository.searchProvince(event.text);
      emit(SelectProvinceSearchResultState(provinces));
    });
  }
}
