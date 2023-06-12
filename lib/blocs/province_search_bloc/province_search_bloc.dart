import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'province_search_event.dart';

part 'province_search_state.dart';

class ProvinceSearchBloc
    extends Bloc<ProvinceSearchEvent, ProvinceSearchState> {
  ProvinceSearchBloc() : super(const ProvinceSearchState()) {
    on<ProvinceSearchChanged>(_onProvinceSearchChanged);
  }

  void _onProvinceSearchChanged(
      ProvinceSearchChanged event, Emitter<ProvinceSearchState> emit) {
    emit(state.copyWith(str: event.str));
  }
}
