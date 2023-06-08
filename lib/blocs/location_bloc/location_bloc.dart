import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practices/repositories/location_repository.dart';

import '../../models/models.dart';

part 'location_event.dart';

part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _locationRepository;

  LocationBloc({required LocationRepository locationRepository})
      : _locationRepository = locationRepository,
        super(const LocationState()) {
    on<LocationProvinceLoaded>(_onLocationProvinceLoaded);
    on<LocationChanged>(_onLocationChanged);
  }

  Future<void> _onLocationProvinceLoaded(
      LocationProvinceLoaded event, Emitter<LocationState> emit) async {
    emit(state.copyWith(
      provinceList: await _locationRepository.getProvince,
    ));
  }

  Future<void> _onLocationChanged(
      LocationChanged event, Emitter<LocationState> emit) async {
    emit(state.copyWith(
      selectedProvince: event.selectedProvince,
      selectedAmphure: event.selectedAmphure,
      selectedTambon: event.selectedTambon,
      amphureList: event.selectedProvince != null
          ? await _locationRepository
              .getAmphureByProvinceId(event.selectedProvince!.id)
          : null,
      tambonList: event.selectedAmphure != null
          ? await _locationRepository
              .getTambonByAmphureId(event.selectedAmphure!.id)
          : null,
    ));
  }
}
