part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

class LocationProvinceLoaded extends LocationEvent {
  const LocationProvinceLoaded();
}

class LocationChanged extends LocationEvent {
  final Province? selectedProvince;
  final Amphure? selectedAmphure;
  final Tambon? selectedTambon;

  const LocationChanged({
    this.selectedProvince,
    this.selectedAmphure,
    this.selectedTambon,
  });

  @override
  List<Object?> get props =>
      [selectedProvince, selectedAmphure, selectedTambon];
}
